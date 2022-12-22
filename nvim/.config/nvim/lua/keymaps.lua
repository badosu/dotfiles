local set = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }
local g = vim.g
local cmd = vim.cmd

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
