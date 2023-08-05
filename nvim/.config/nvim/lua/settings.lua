local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local env = vim.env

vim.opt.compatible = false
vim.opt.mouse = 'a'
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars:append "tab:▷⋮"
vim.opt.listchars:append "trail:."
-- vim.opt.listchars:append "eol:↴"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.opt.report = 1000

-- Better display for messages
-- opt.hidden = true

vim.opt.diffopt = vim.opt.diffopt:append('vertical')
-- opt.colorcolumn = 100

-- "time waited for key press(es) to complete. It makes for a faster key response
vim.opt.ttimeout = true
vim.opt.timeout = true
vim.opt.ttimeoutlen = 0
vim.opt.timeoutlen = 0

vim.opt.wrapscan = false

-- set formatoptions-=cro        " disable automatic comments on newline
-- vim.opt.shortmess = 'filnxtToOFIscWC'
vim.o.shortmess = "filnxtToOFIscC"
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

vim.opt.verbose = 0
-- don't give |ins-completion-menu| messages.
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options (for nvim-cmp)
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode

vim.opt.guifont = "Iosevka Term 15"
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.wrapscan = true
vim.opt.undofile = true
-- vim.opt.undodir = '~/.local/state/nvim/undo' should be default? I dont see a file there
if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
  vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
end

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

local signs = { Error = "×", Warn = "", Hint = "💡", Info = "¡" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
