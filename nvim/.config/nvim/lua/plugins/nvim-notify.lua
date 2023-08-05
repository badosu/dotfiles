local notify = require("notify")

local opts = {
  level = vim.log.levels.INFO,
  render = "minimal",
}

if vim.g.neovide then
  opts.background_colour = "#000000"
end

notify.setup(opts)

require('telescope').load_extension('notify')
