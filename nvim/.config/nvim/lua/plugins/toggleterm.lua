require("toggleterm").setup({
  open_mapping = "<c-t>",
  direction = "float"
  --  insert_mappings = true
})

local function setWinCmds()
  local opts = { buffer = 0 }
  --  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", { callback = setWinCmds })

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.keymap.set("n", "q", vim.cmd.close, { noremap = true, silent = true, buffer = term.bufnr })
  end,
  -- function to run on closing the terminal
  on_close = function()
    vim.cmd("startinsert!")
  end,
})

local function lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_create_user_command('ToggleLazyGit', lazygit_toggle, {})

vim.keymap.set("n", "<C-S-t>", ":ToggleTerm direction=tab<CR>")
vim.keymap.set("n", "<C-A-t>", ":ToggleTerm direction=float<CR>")

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
