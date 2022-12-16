local set = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }
local s = { noremap = true, silent = true }
local g = vim.g

g.mapleader = ','

-- FZF
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, s)
vim.keymap.set('n', '<leader>g', builtin.live_grep, s)
vim.keymap.set('n', '<leader>s', builtin.treesitter, s)
vim.keymap.set('n', '<leader>h', builtin.help_tags, s)
vim.keymap.set('n', '<leader>Q', builtin.quickfix, s)
vim.keymap.set('n', '<leader>r', builtin.registers, s)
vim.keymap.set('n', '<leader>R', builtin.resume, s)
vim.keymap.set('n', '<leader>gb', builtin.git_branches, s)
vim.keymap.set('n', '<leader>gs', builtin.git_status, s)
vim.keymap.set('n', '<leader>gt', builtin.git_stash, s)

set('n', '<leader>p',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    ns)

-- Debugging

set('n', '<F8>',
    "<cmd>lua require('dap').toggle_breakpoint()<CR>",
    ns)
set('n', '<F10>',
    "<cmd>lua require('dap').step_over()<CR>",
    ns)
set('n', '<F11>',
    "<cmd>lua require('dap').step_into()<CR>",
    ns)
set('n', '<F12>',
    "<cmd>lua require('dap').step_out()<CR>",
    ns)
set('n', '<F5>',
    "<cmd>lua require('dapui').open(); require('dap').continue()<CR>",
    ns)
set('n', '<F6>',
    "<cmd>require('dap').run_last()<CR>",
    ns)
set('n', '<F7>',
    "<cmd>lua require('dapui').close(); require('dap').terminate()<CR>",
    ns)
set('n', '<leader>dr',
    "<cmd>lua require('dap').repl.open()<CR>",
    ns)
set('n', '<leader>df',
    "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>",
    ns)
set('n', '<leader>dd',
    "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
    ns)
set('n', '<leader>db',
    "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
    ns)
set('n', '<leader>dv',
    "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
    ns)
set('n', '<leader>b',
    "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    ns)
set('n', '<leader>B',
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    ns)
-- 

--set('n', ']c',
--    "<Plug>(GitGutterNextHunk)",
--    ns)
--set('n', '[c',
--    "<Plug>(GitGutterPrevHunk)",
--    ns)

 vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', ns)
 vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', ns)
 vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', ns)
 vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', ns)
 vim.api.nvim_set_keymap('n', '<leader>Q', '<cmd>lua vim.diagnostic.setloclist()<CR>', ns)
-- 
 vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', ns)
 vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', ns)
 vim.api.nvim_set_keymap('n', 'K', '<cmd>lua if require("dap").session() then require("dapui").eval() else vim.lsp.buf.hover() end<CR>', ns)
 vim.api.nvim_set_keymap('v', 'K', '<cmd>lua require("dapui").eval()<CR>', ns)
 vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', ns)
-- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', ns)
  vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true })
 vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', ns)
 vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>', ns)
 vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>lua vim.lsp.buf.formatting()<CR>', ns)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- 
--   -- Mappings.
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- end


-- Git Messenger
set('n', '<leader>m', "<Plug>(git-messenger)", ns)
set('n', '<leader>T', '<cmd>ToggleTerm<CR>', ns)

set('n', '<leader>T', '<cmd>ToggleTerm<CR>', ns)

-- incorporate vim-slash without boilerplate
vim.cmd([[
  function! s:wrap(seq)
    if mode() == 'c' && stridx('/?', getcmdtype()) < 0
      return a:seq
    endif
    silent! autocmd! slash
    set hlsearch
    return a:seq."\<plug>(slash-trailer)"
  endfunction

  function! s:immobile(seq)
    let s:winline = winline()
    let s:pos = getpos('.')
    return a:seq."\<plug>(slash-prev)"
  endfunction

  function! s:trailer()
    augroup slash
      autocmd!
      autocmd CursorMoved,CursorMovedI * set nohlsearch | autocmd! slash
    augroup END

    let seq = foldclosed('.') != -1 ? 'zv' : ''
    if exists('s:winline')
      let sdiff = winline() - s:winline
      unlet s:winline
      if sdiff > 0
        let seq .= sdiff."\<c-e>"
      elseif sdiff < 0
        let seq .= -sdiff."\<c-y>"
      endif
    endif
    let after = len(maparg("<plug>(slash-after)", mode())) ? "\<plug>(slash-after)" : ''
    return seq . after
  endfunction

  function! s:trailer_on_leave()
    augroup slash
      autocmd!
      autocmd InsertLeave * call <sid>trailer()
    augroup END
    return ''
  endfunction

  function! s:prev()
    return getpos('.') == s:pos ? '' : '``'
  endfunction

  function! s:escape(backward)
    return '\V'.substitute(escape(@", '\' . (a:backward ? '?' : '/')), "\n", '\\n', 'g')
  endfunction

  map      <expr> <plug>(slash-trailer) <sid>trailer()
  imap     <expr> <plug>(slash-trailer) <sid>trailer_on_leave()
  cnoremap        <plug>(slash-cr)      <cr>
  noremap  <expr> <plug>(slash-prev)    <sid>prev()
  inoremap        <plug>(slash-prev)    <nop>
  noremap!        <plug>(slash-nop)     <nop>

  cmap <expr> <cr> <sid>wrap("\<cr>")
  map  <expr> n    <sid>wrap('n')
  map  <expr> N    <sid>wrap('N')
  map  <expr> *    <sid>wrap(<sid>immobile('*'))
  map  <expr> #    <sid>wrap(<sid>immobile('#'))
  map  <expr> g*   <sid>wrap(<sid>immobile('g*'))
  map  <expr> g#   <sid>wrap(<sid>immobile('g#'))
  xmap <expr> *    <sid>wrap(<sid>immobile("y/\<c-r>=<sid>escape(0)\<plug>(slash-cr)\<plug>(slash-cr)"))
  xmap <expr> #    <sid>wrap(<sid>immobile("y?\<c-r>=<sid>escape(1)\<plug>(slash-cr)\<plug>(slash-cr)"))

  noremap <plug>(slash-after) zz
]])
--command! Nextmatch sil norm n
--nnoremap <silent> n :Nextmatch<cr>"

-- nmap <Leader>m <Plug>(git-messenger)
-- 
-- -----
-- --
-- nnoremap <leader>j :%!jq '.'<CR>
-- nnoremap <leader>w :nohlsearch<CR>
-- nnoremap <leader>t :belowright<Space>split<Space><bar><Space>resize<Space>10<Space><bar><Space>terminal<CR>ivmux<CR>
-- nnoremap <leader>T :belowright<Space>split<Space><bar><Space>resize<Space>10<Space><bar><Space>terminal<CR>i
-- 
-- -----
-- --
-- --
-- nmap <Leader>ha <Plug>GitGutterStageHunk
-- nmap <Leader>hr <Plug>GitGutterUndoHunk
-- 
-- 
-- -- Random shit
-- --
-- -- make Y consistent with C and D.
-- nnoremap Y y$
-- 
-- -- make n always search forward and N backward
-- nnoremap <expr> n 'Nn'[v:searchforward]
-- nnoremap <expr> N 'nN'[v:searchforward]
-- 
-- -- make ; always "find" forward and , backward
-- nnoremap <expr> ; getcharsearch().forward ? ';' : ','
-- nnoremap <expr> , getcharsearch().forward ? ',' : ';'
-- 
-- -- make ; and , be on the same key
-- -- nnoremap : ,
-- -- nnoremap ` :
-- -- nnoremap ' `
-- 
-- -- make J, K, L, and H move the cursor MORE.
-- -- nnoremap J }
-- -- nnoremap K {
-- -- nnoremap L g_
-- -- nnoremap H ^
-- 
-- -- make <c-j>, <c-k>, <c-l>, and <c-h> scroll the screen.
-- nnoremap <c-j> <c-e>
-- nnoremap <c-k> <c-y>
-- nnoremap <c-l> zl
-- nnoremap <c-h> zh
-- 
-- -- make <a-j>, <a-k>, <a-l>, and <a-h> move to window.
-- nnoremap <a-j> <c-w>j
-- nnoremap <a-k> <c-w>k
-- nnoremap <a-l> <c-w>l
-- nnoremap <a-h> <c-w>h
-- 
-- -- make <a-J>, <a-K>, <a-L>, and <a-H> create windows.
-- nnoremap <a-J> <c-w>s<c-w>k
-- nnoremap <a-K> <c-w>s
-- nnoremap <a-H> <c-w>v
-- nnoremap <a-L> <c-w>v<c-w>h
-- 
-- -- 
-- tnoremap <Esc> <C-\><C-N>:q<CR>
