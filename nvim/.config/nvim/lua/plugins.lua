require("lazy").setup({
  { "kyazdani42/nvim-web-devicons", event = { "VeryLazy" } },
  { "tpope/vim-unimpaired", event = { "VeryLazy" } },
  { "b0o/incline.nvim", event = { "VeryLazy" } },
  { "simnalamburt/vim-mundo", event = { "VeryLazy" } },
  { "kevinhwang91/nvim-bqf", event = { "VeryLazy" } },

  { "tpope/vim-vinegar", lazy = true, keys = { "-" } },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Ggrep", "Gwrite", "Gread", "Gdiffsplit", "GBrowse", "GDelete" },
    dependencies = { "tpope/vim-rhubarb" }
  },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", function() vim.cmd.TroubleToggle() end },
      { "<leader>xw", function() vim.cmd.TroubleToggle("workspace_diagnostics") end },
      { "<leader>xd", function() vim.cmd.TroubleToggle("document_diagnostics") end },
      { "<leader>xl", function() vim.cmd.TroubleToggle("loclist") end },
      { "<leader>xq", function() vim.cmd.TroubleToggle("quickfix") end },
      { "gr",         function() vim.cmd.TroubleToggle("lsp_references") end },
    },
    cmd = "TroubleToggle"
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "0.1.x",
    lazy = true,
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end },
      { '<leader>fb', function() require('telescope.builtin').buffers() end },
      { '<leader>g',  function() require('telescope.builtin').live_grep() end },
      { '<leader>s',  function() require('telescope.builtin').treesitter() end },
      { '<leader>S',  function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end },
      { '<leader>h',  function() require('telescope.builtin').help_tags() end },
      { '<leader>Q',  function() require('telescope.builtin').quickfix() end },
      { '<leader>r',  function() require('telescope.builtin').registers() end },
      { '<leader>R',  function() require('telescope.builtin').resume() end },
      { '<leader>gb', function() require('telescope.builtin').git_branches() end },
      { '<leader>gs', function() require('telescope.builtin').git_status() end },
      { '<leader>gt', function() require('telescope.builtin').git_stash() end },
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, build = "make", config = function() require('telescope').load_extension('fzf') end, event = { "VeryLazy" } },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require('plugins.telescope-project') end,
    lazy = true,
    keys = {
      { '<leader>p', function() require('telescope').extensions.project.project() end }
    }
  },

  { "catppuccin/nvim", config = function() require('plugins.catppuccin') end },
  --"lukas-reineke/indent-blankline.nvim",

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")

      if vim.g.neovide then
        vim.notify.setup({
          background_colour = "#000000",
        })
      end
    end
  },

  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" }, config = function() require('plugins.noice') end },

  { "akinsho/toggleterm.nvim", tag = "2.3.0", config = function() require('plugins.toggleterm') end, keys = { "<leader>t" } },

  {
    "neovim/nvim-lspconfig",
    config = function() require 'plugins.lsp-config' end,
    dependencies = { "folke/neodev.nvim" },
    event = { "VeryLazy" },
    keys = {
      { '<leader>e', vim.diagnostic.open_float },
      { 'gD', vim.lsp.buf.declaration },
      { 'gd', vim.lsp.buf.definition },
      { 'gi', vim.lsp.buf.implementation },
      { '<leader>ca', vim.lsp.buf.code_action },
      { '<leader>w', vim.lsp.buf.format },
    }
  },
  { "folke/neodev.nvim", config = true, lazy = true },

  { "L3MON4D3/LuaSnip", lazy = true },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function() require('plugins.nvim-cmp') end
  },
  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
    config = function()
      local cmp = require('cmp')
      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources(
          { { name = 'path' } },
          { { name = 'cmdline' } }
        )
      })
    end,
  },

  {
    "hrsh7th/cmp-buffer",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    event = { "InsertEnter" },
  },

  {
    "smjonas/inc-rename.nvim",
    config = function() require('plugins.increname') end,
    lazy = true,
    keys = {
      { "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, expr = true },
      { "<leader>rN", function() return ":IncRename " end, expr = true },
    }
  },

  { "kdheepak/tabline.nvim", config = function() require('plugins.tabline') end },

  { "lewis6991/gitsigns.nvim", config = function() require('plugins.gitsigns') end, event = { "VeryLazy" } },

  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.g.git_messenger_no_default_mappings = true
    end,
    lazy = true,
    keys = {
      { '<leader>m', "<Plug>(git-messenger)" }
    }
  },

  { "simrat39/symbols-outline.nvim", config = true, lazy = true },
  { "nvim-lualine/lualine.nvim", config = function() require('plugins.lualine') end, dependencies = { "folke/noice.nvim" } },
  { "nvim-treesitter/nvim-treesitter", config = function() require('plugins.nvim-treesitter') end, build = vim.cmd.TSUpdate },

  {
    "mfussenegger/nvim-dap",
    config = function() require('plugins.nvim-dap') end,
    lazy = true,
    keys = {
      { '<F8>',  function() require('dap').toggle_breakpoint() end },
      { '<F10>', function() require('dap').step_over() end },
      { '<F11>', function() require('dap').step_into() end },
      { '<F12>', function() require('dap').step_out() end },
      { '<F5>', function() require('dapui').open(); require('dap').continue() end },
      { '<F6>', function() require('dap').run_last() end },
      { '<F7>', function() require('dapui').close(); require('dap').terminate() end },
      { '<leader>dr', function() require('dap').repl.open() end },
      { '<leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
      { '<leader>dL', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
      { 'K', function() if require("dap").session() then require("dapui").eval() else vim.lsp.buf.hover() end end },
      { 'K', function() require("dapui").eval() end, mode = "v" },
    }
  },
  { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" }, lazy = true },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, lazy = true },
  {
    "rcarriga/cmp-dap",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = { "dap-repl", "dapui_watches", "dapui_hover" },
    config = function()
      require('cmp').setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require('telescope').load_extension('dap') end,
    lazy = true,
    keys = {
      { '<leader>df', function() require('telescope').extensions.dap.frames() end },
      { '<leader>dd', function() require('telescope').extensions.dap.commands() end },
      { '<leader>db', function() require('telescope').extensions.dap.list_breakpoints() end },
      { '<leader>dv', function() require('telescope').extensions.dap.variables() end },
    }
  },
})

require('plugins.vim-slash')
