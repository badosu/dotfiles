local wk = require("which-key")

local curry = require('utils').curry

wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = {
    ["<leader>"] = vim.g.mapleader
  },
})

local leader = {
  ["d"] = {
    name = "+debugger",
  },
  ["f"] = {
    name = "+find",
  },
  ["r"] = {
    name = "+refactor",
  },
  ["x"] = {
    name = "+diagnostics",
  },
  ["h"] = {
    name = "+git",
  },
  ["u"] = {
    name = "+utils",
  },
  ["q"] = { vim.cmd.copen, "Open Quickfix" },
  ["l"] = {
    name = "+lazy",
    l = { vim.cmd.Lazy, "Open" },
    L = { function() return ":Lazy load " end, "Load plugin", expr = true },
    p = { curry(vim.cmd.Lazy, "profile"), "Profile" },
    i = { curry(vim.cmd.Lazy, "install"), "Install" },
    u = { curry(vim.cmd.Lazy, "update"), "Update" },
    c = { curry(vim.cmd.Lazy, "clean"), "Clean" },
    C = { curry(vim.cmd.Lazy, "check"), "Check" },
    h = { curry(vim.cmd.Lazy, "help"), "Help" },
    K = { curry(vim.cmd.Lazy, "clear"), "Clear" },
    d = { curry(vim.cmd.Lazy, "debug"), "Debug" },
    H = { curry(vim.cmd.Lazy, "log"), "Log" },
    r = { curry(vim.cmd.Lazy, "restore"), "Restore" },
    s = { curry(vim.cmd.Lazy, "sync"), "Sync" },
  },
}

wk.register({ g = { name = "+goto" } })
wk.register(leader, { prefix = "<leader>" })
wk.register({ "[", "]" }) -- pair mappings

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "quickfix",
  callback = function(opts)
    vim.api.nvim_buf_set_keymap(opts.buf, 'n', 'q', ':cclose<cr>', { noremap = true, silent = true })
  end,
})


-- local set = vim.api.nvim_set_keymap
-- local ns = { noremap = true, silent = true }
-- local g = vim.g
-- local cmd = vim.cmd

--command! Nextmatch sil norm n
--nnoremap <silent> n :Nextmatch<cr>"

-- nnoremap <leader>j :%!jq '.'<CR>
-- nnoremap <leader>w :nohlsearch<CR>
-- nnoremap <leader>t :belowright<Space>split<Space><bar><Space>resize<Space>10<Space><bar><Space>terminal<CR>ivmux<CR>
-- nnoremap <leader>T :belowright<Space>split<Space><bar><Space>resize<Space>10<Space><bar><Space>terminal<CR>i
-- 
-- -----
-- --
-- --
-- -- Random shit
-- --
-- -- make Y consistent with C and D.
-- nnoremap Y y$
-- 
-- -- make J, K, L, and H move the cursor MORE.
-- -- nnoremap J }
-- -- nnoremap K {
-- -- nnoremap L g_
-- -- nnoremap H ^
