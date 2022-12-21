-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['solargraph'].setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
}

require('lspconfig')['ccls'].setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

require('lspconfig')['sumneko_lua'].setup {
  -- on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'Lua 5.1',
      },
      completion = {
        callSnippet = "Replace"
      },
      --misc = {
      --  parameters = {'--loglevel', 'trace', '--configpath', '/home/badosu/sumnekologs'},
      --},
    },
  },
}

require'lspconfig'.pylsp.setup{
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          -- ignore = {'W391'},
          -- maxLineLength = 100
        }
      }
    }
  }
}
