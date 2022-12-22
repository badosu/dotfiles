require("toggleterm").setup({
  open_mapping = ",t",
})

-- vim.keymap.set('t', '<leader>T', ':ToggleTerm direction=float<CR>', opts)
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- ToggleTerm
--set('n', '<leader>t', ':ToggleTerm direction=float<CR>', ns)

--local Terminal  = require('toggleterm.terminal').Terminal
--local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
--
--function _lazygit_toggle()
--  lazygit:toggle()
--end
--
--api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
