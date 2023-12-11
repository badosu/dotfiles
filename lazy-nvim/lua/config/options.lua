-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.title = true
vim.opt.clipboard = "unnamed"
vim.opt.relativenumber = false
vim.opt.undofile = true
vim.opt.swapfile = false
vim.g.editorconfig = true

---@type LazyRootSpec[]
vim.g.root_spec = { { ".git", "mix.exs", "Gemfile", "lua" }, "lsp", "cwd" }
-- vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.cmd([[
" Enable Mouse
set mouse=a

set guifont=monospace:h18
]])
