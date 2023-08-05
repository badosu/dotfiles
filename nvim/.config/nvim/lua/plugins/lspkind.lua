require('cmp').setup({
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end

      return require('lspkind').cmp_format({ with_text = false, maxwidth = 50, mode = "symbol_text" })(entry, vim_item)
    end
  }
})
