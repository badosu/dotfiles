-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

require('lspconfig')['solargraph'].setup {
  -- on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

require('lspconfig')['ccls'].setup {
  -- on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

require('lspconfig')['sumneko_lua'].setup {
  -- on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
}

require'lspconfig'.pylsp.setup{
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
