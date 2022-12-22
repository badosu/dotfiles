local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn
local env = vim.env

opt.cmdheight = 0
opt.compatible = false
opt.mouse = 'a'
opt.swapfile = false
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.autoread = true
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.termguicolors = true
opt.list = true
opt.listchars:append "tab:▷⋮"
opt.listchars:append "trail:."
-- vim.opt.listchars:append "eol:↴"
opt.updatetime = 50
opt.splitbelow = true
opt.splitright = true
opt.autoindent = true
opt.expandtab = false

-- Better display for messages
-- opt.hidden = true

opt.diffopt = opt.diffopt
                :append('vertical')
-- opt.colorcolumn = 100

-- "time waited for key press(es) to complete. It makes for a faster key response
opt.ttimeout = true
opt.ttimeoutlen = 50

opt.wrapscan = false

-- set formatoptions-=cro        " disable automatic comments on newline
opt.shortmess = 'filnxtToOFIscWC'
--opt.shortmess = opt.shortmess:append{
--  f = true,
--  i = true,
--  l = true,
--  n = true,
--  x = true,
--  t = true,
--  T = true,
--  o = true,
--  O = true,
--  F = true, --	  F	don't give the file info when editing a file, like `:silent`
--  I = true, --don't give the intro message when starting Vim |:intro|.
--  s = true, --don't give "search hit BOTTOM, continuing at TOP" or "search
--  c = true, --	  c	don't give |ins-completion-menu| messages.  For example, "-- XXX completion (YYY)", "match 1 of 2", "The only match",
--  W = true, ----	  W	don't give "written" or "[w]" when writing a file
--  S = true, --	  S     do not show search count message when searching, e.g.
--  C = true, --	  C	don't give messages while scanning for ins-completion items, for instance "scanning tags"
--}

opt.verbose = 0
-- don't give |ins-completion-menu| messages.
opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options (for nvim-cmp)

opt.guifont = 'Iosevka Term:h18'
opt.pumblend = 8
opt.winblend = 8
opt.wrapscan = true
opt.undofile = false
opt.undodir = '~/.vim/undo'

g.neovide_cursor_animation_length = 0
g.neovide_scroll_animation_length = 0
g.neovide_hide_mouse_when_typing = true
g.neovide_floating_blur_amount_x = 2.0
g.neovide_floating_blur_amount_y = 2.0

cmd [[set path+=/home/badosu/.local/share/gem/ruby/3.0.0/bin]]
cmd [[set path+=/home/badosu/perl5/bin]]

fn.setenv('GEM_HOME', '/home/badosu/.local/share/gem/ruby/3.0.0/bundle')
fn.setenv('PERL5LIB', '/home/badosu/perl5/lib/perl5' .. (env.PERL5LIB and ':' .. env.PERL5LIB or ''))
fn.setenv('PERL_LOCAL_LIB_ROOT', '/home/badosu/perl5' .. (env.PERL_LOCAL_LIB_ROOT and ':' .. env.PERL_LOCAL_LIB_ROOT or ''))
fn.setenv('PERL_MB_OPT', '--install_base \"/home/badosu/perl5\"')
fn.setenv('PERL_MM_OPT', 'INSTALL_BASE=/home/badosu/perl5')
