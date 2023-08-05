-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local utils = require("utils")
local curry = utils.curry
local curryRequire = utils.curryRequire

local wk = require('which-key')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, buffer)
  local cap = client.server_capabilities

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = buffer,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
        vim.lsp.buf.format({
          async = true,
          bufnr = buffer,
          --filter = function(cl)
          --  return cl.name == "null-ls"
          --end,
          timeout_ms = 3000,
        })
      end,
    })
  end

  local keymap = {
    buffer = buffer,
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Next Diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Prev Diagnostic" },
    ["[E"] = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", "Next Error" },
    ["]E"] = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", "Prev Error" },
    g = {
      D = { vim.lsp.buf.declaration, "Declaration" },
      d = { vim.lsp.buf.definition, "Definition" },
      i = { vim.lsp.buf.implementation, "Implementation" },
      r = { curryRequire('telescope.builtin', 'lsp_references'), "Reference" },
    },
    ["<leader>"] = {
      f = {
        m = { curryRequire('telescope.builtin', 'lsp_dynamic_workspace_symbols'), "Workspace Symbols" },
      },
      r = {
        ---@diagnostic disable-next-line: redundant-return-value
        n = {
          function() return ":IncRename " .. vim.fn.expand("<cword>") end,
          "Rename",
          expr = true,
          cond = cap.renameProvider
        },
        ---@diagnostic disable-next-line: redundant-return-value
        N = { function() return ":IncRename " end, "Rename (from start)", expr = true, cond = cap.renameProvider },
        a = {
          { vim.lsp.buf.code_action, "Actions" },
          { vim.lsp.buf.code_action, "Actions", mode = "v" },
        },
        w = {
          { vim.lsp.buf.format,                                  "Format file",  cond = cap.documentFormatting, },
          { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format range", cond = cap.documentRangeFormatting,
                                                                                                                       mode =
            "v" },
        }
      },
      w = {
        name = "+workspace",
        a = { vim.lsp.buf.add_workspace_folder, "Add folder" },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove folder" },
        l = { function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List folders" },
      },
      x = {
        e = { vim.diagnostic.open_float, "Current line" },
        p = { vim.cmd.TroubleToggle, "Project" },
        w = { curry(vim.cmd.TroubleToggle, "workspace_diagnostics"), "Workspace" },
        x = { curry(vim.cmd.TroubleToggle, "document_diagnostics"), "Document" },
        l = { curry(vim.cmd.TroubleToggle, "loclist"), "Location list" },
        q = { curry(vim.cmd.TroubleToggle, "quickfix"), "Quickfix" },
      },
    },
  }

  wk.register(keymap)
end

require('lspconfig').solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}

--require('lspconfig').ccls.setup {
--  capabilities = capabilities,
--  on_attach = on_attach,
--}

local function switch_source_header_splitcmd(bufnr, client, splitcmd)
  return function()
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    client.request("textDocument/switchSourceHeader", params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        print("Corresponding file can’t be determined")
        return
      end
      print(splitcmd .. ' ' .. vim.uri_to_fname(result))
      vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end, bufnr)
  end
end

require('lspconfig').clangd.setup {
  capabilities = capabilities,
  on_attach = function(client, buffer)
    on_attach(client, buffer)

    local keymap = {
      buffer = buffer,
      ["<leader>"] = {
        a = { switch_source_header_splitcmd(buffer, client, ":e"), "Open Alternate" },
        A = { switch_source_header_splitcmd(buffer, client, ":vsplit"), "Open Alternate (vsplit)" },
        ["<C-a>"] = { switch_source_header_splitcmd(buffer, client, ":tabnew"), "Open Alternate (tabnew)" },
      },
    }

    wk.register(keymap)
  end,
}

require('lspconfig').lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'Lua 5.1',
      },
      completion = {
        callSnippet = "Replace"
      },
      workspace = {
        checkThirdParty = false
      },
      --misc = {
      --  parameters = {'--loglevel', 'trace', '--configpath', '/home/badosu/sumnekologs'},
      --},
    },
  },
}

require 'lspconfig'.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  settings = {
  }
})

require('lspconfig').pylsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.eslint.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  -- cmd = { "zsh", "-c", "source /usr/share/nvm/init-nvm.sh; vscode-eslint-language-server --stdio" },
  -- settings = {
  --   nodePath = "/home/badosu/.nvm/versions/node/v16.14.2/bin/node",
  -- }
}

capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.erb_format.with({
      command = "bundle",
      args = vim.list_extend(
        { "exec", "erb-format" },
        null_ls.builtins.formatting.erb_format._opts.args
      ),
      disabled_filetypes = { "eruby.yaml" },
    }),
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.eslint,
  },
  on_attach = function(client, buffer)
    on_attach(client, buffer)
  end,
})
