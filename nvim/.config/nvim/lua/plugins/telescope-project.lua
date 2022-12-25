local telescope = require('telescope')
telescope.setup({
  extensions = {
    project = {
      base_dirs = {
        '~/Code',
      },
      --hidden_files = true, -- default: false
      theme = "dropdown",
      order_by = "asc",
      --sync_with_nvim_tree = true, -- default false
    }
  }
})
telescope.load_extension('project')

local ns = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>p', telescope.extensions.project.project, ns)
