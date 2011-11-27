" Fugitive status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" No fancy stuff
set guioptions-=T
set guioptions-=m
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=b

if (has("gui_running"))
	" Colorscheme
	let g:sienna_style='dark'
	colorscheme sienna

	" Size of window
	set lines=40 columns=150
endif

" Nice font
set guifont=Anonymous\ Pro\ 12

" Set linenumbers on
set number

" Put linenumbers on left
set numberwidth=1

" Indentation
set shiftwidth=2
set tabstop=2

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent shiftwidth=2 nofoldenable expandtab
" Taglist
"
let Tlist_Enable_Fold_Column = 0
let Tlist_Compact_Format = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_GainFocus_On_ToggleOpen = 1

map <F5> :TlistToggle<cr>
vmap <F5> <esc>:TlistToggle<cr>
imap <F5> <esc>:TlistToggle<cr>

" Nerdtree
let Tlist_Use_Right_Window = 1
map <F4> :NERDTreeToggle<cr> <C-w>10<
vmap <F4> <esc>:NERDTreeToggle<cr> <C-w>10<
imap <F4> <esc>:NERDTreeToggle<cr> <C-w>10<

" Nice complete
function! Smart_TabComplete()
  let line = getline('.')                         " curline
  let substr = strpart(line, -1, col('.')+1)      " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-U>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
