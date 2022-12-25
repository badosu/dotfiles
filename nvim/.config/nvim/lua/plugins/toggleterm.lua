require("toggleterm").setup({
  open_mapping = ",t",
})

local termopts = { buffer = 0 }
local function setWinCmds()
  vim.keymap.set('t', '<C-w>h', function() vim.cmd.wincmd('h') end, termopts)
  vim.keymap.set('t', '<C-w>j', function() vim.cmd.wincmd('j') end, termopts)
  vim.keymap.set('t', '<C-w>k', function() vim.cmd.wincmd('k') end, termopts)
  vim.keymap.set('t', '<C-w>l', function() vim.cmd.wincmd('l') end, termopts)
end

vim.api.nvim_create_autocmd("TermOpen", { callback = setWinCmds })
-- vim.keymap.set('t', '<leader>T', ':ToggleTerm direction=float<CR>', opts)
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
