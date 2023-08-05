require('gitsigns').setup {
  trouble = false,
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      if type(opts) == "string" then
        opts = { desc = opts }
      end
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', "Stage hunk")
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', "Reset hunk")
    map('n', '<leader>hS', gs.stage_buffer, "Stage buffer")
    map('n', '<leader>hu', gs.undo_stage_hunk, "Stage hunk (undo)")
    map('n', '<leader>hR', gs.reset_buffer, "Reset buffer")
    map('n', '<leader>hp', gs.preview_hunk, "Preview hunk")
    map('n', '<leader>hb', function() gs.blame_line{full=true} end, "Blame line")
    map('n', '<leader>hB', gs.toggle_current_line_blame, "Toggle current line blame")
    map('n', '<leader>hd', gs.diffthis, "Diff this")
    map('n', '<leader>hD', function() gs.diffthis('~') end, "Diff open")
    map('n', '<leader>hx', gs.toggle_deleted, "Toggle deleted")
    map('n', '<leader>hb', function() require('telescope.builtin').git_branches() end, "Branches")
    map('n', '<leader>hs', function() require('telescope.builtin').git_status() end, "Status")
    map('n', '<leader>ht', function() require('telescope.builtin').git_stash() end, "Stash")

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "inner hunk")
  end
}
