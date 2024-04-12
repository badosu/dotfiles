-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.title = true
vim.opt.clipboard = "unnamed"
vim.opt.relativenumber = false
vim.opt.undofile = true
vim.opt.swapfile = false
vim.g.editorconfig = true

vim.o.winblend = 40

vim.g.neovide_window_blurred = true
vim.g.neovide_transparency = 0.95

vim.g.neovide_floating_blur = true
vim.g.neovide_floating_opacity = 0
vim.g.neovide_floating_blur_amount_x = 2.5
vim.g.neovide_floating_blur_amount_y = 2.5

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

---@type LazyRootSpec[]
vim.g.root_spec = { { ".git", "mix.exs", "Gemfile", "lua" }, "lsp", "cwd" }
-- vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

if vim.fn.has("gui_running") then
  -- vim.cmd("set guifont=JetBrainsMono\\ NFM:h10")
  vim.opt.guifont = "FiraCode Nerd Font Mono:h16"
end

vim.opt.mouse = "a"
