local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_signature_help' },
    },
    { { name = 'buffer' } }
  )
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
})

require("luasnip.loaders.from_vscode").lazy_load()
