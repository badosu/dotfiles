local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/badosu/Code/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/usr/bin/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
  {
    name = "Launch spring",
    type = "cppdbg",
    request = "launch",
    program = '/home/badosu/Code/spring/build-linux-64-DEBUG/install/spring',
    args = { '--isolation', '--write-dir', '~/engine-write' },
    --args = { '--isolation', '--write-dir', '~/Documents/Beyond All Reason' },
    --args = { '--isolation', '--write-dir', '~/engine-write', '~/Downloads/20221120_214019_SpeedMetal_BAR_V2_105.1.1-1354-g72b2d55_BAR105.sdfz' },
    cwd = '${workspaceFolder}',
    stopAtEntry = false,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    }
  },
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("nvim-dap-virtual-text").setup()

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        --"repl",
        "console",
        { id = "repl", size = 0.3 },
      },
      size = 0.4, -- 25% of total lines
      position = "bottom",
    },
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        --{ id = "scopes", size = 0.25 },
        "scopes",
        --"breakpoints",
        "stacks",
        --"watches",
      },
      size = 50,
      position = "left",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = false,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

local set = vim.keymap.set
local ns = { noremap = true, silent = true }

local telescope = require('telescope')

set('n', '<F8>', dap.toggle_breakpoint, ns)
set('n', '<F10>', dap.step_over, ns)
set('n', '<F11>', dap.step_into, ns)
set('n', '<F12>', dap.step_out, ns)
set('n', '<F5>', function() require('dapui').open(); dap.continue() end, ns)
set('n', '<F6>', dap.run_last, ns)
set('n', '<F7>', function() require('dapui').close(); dap.terminate() end, ns)
set('n', '<leader>dr', dap.repl.open, ns)
set('n', '<leader>df', function() telescope.extensions.dap.frames() end, ns)
set('n', '<leader>dd', function() telescope.extensions.dap.commands() end, ns)
set('n', '<leader>db', function() telescope.extensions.dap.list_breakpoints() end, ns)
set('n', '<leader>dv', function() telescope.extensions.dap.variables() end, ns)
set('n', '<leader>b', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, ns)
set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, ns)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua if require("dap").session() then require("dapui").eval() else vim.lsp.buf.hover() end<CR>', ns)
vim.api.nvim_set_keymap('v', 'K', '<cmd>lua require("dapui").eval()<CR>', ns)
