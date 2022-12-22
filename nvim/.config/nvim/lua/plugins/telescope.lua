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
telescope.load_extension('dap')
telescope.load_extension('fzf')
telescope.load_extension('project')

local ns = { noremap = true, silent = true }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, ns)
vim.keymap.set('n', '<leader>g', builtin.live_grep, ns)
vim.keymap.set('n', '<leader>s', builtin.treesitter, ns)
vim.keymap.set('n', '<leader>S', builtin.lsp_dynamic_workspace_symbols, ns)
vim.keymap.set('n', '<leader>h', builtin.help_tags, ns)
vim.keymap.set('n', '<leader>Q', builtin.quickfix, ns)
vim.keymap.set('n', '<leader>r', builtin.registers, ns)
vim.keymap.set('n', '<leader>R', builtin.resume, ns)
vim.keymap.set('n', '<leader>gb', builtin.git_branches, ns)
vim.keymap.set('n', '<leader>gs', builtin.git_status, ns)
vim.keymap.set('n', '<leader>gt', builtin.git_stash, ns)
vim.keymap.set('n', '<leader>p', telescope.extensions.project.project, ns)
