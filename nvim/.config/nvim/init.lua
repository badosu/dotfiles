vim.g.mapleader = ','

require 'lazy_bootstrap'
require 'plugins'
require 'settings'
require 'keymaps'

local has_menu_item = false
vim.api.nvim_create_autocmd('MenuPopup', {
  callback = function()
    local need_menu_item = vim.bo.filetype == 'markdown'
    if has_menu_item and not need_menu_item then
      vim.cmd.aunmenu([[PopUp.Preview\ Markdown]])
      has_menu_item = false
    elseif not has_menu_item and need_menu_item then
      vim.cmd.anoremenu({
        [[PopUp.Preview\ Markdown]],
        [[<Cmd>call system(['xdg-open', expand('%')])<CR>]],
      })
      has_menu_item = true
    end
  end,
})
