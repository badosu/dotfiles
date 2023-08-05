local utils = require('utils')
local curry = utils.curry
local requirePlugin = utils.curryPlugin
local curryRequire = utils.curryRequire

require("lazy").setup({
  { "kyazdani42/nvim-web-devicons", event = { "VeryLazy" } },
  { "tpope/vim-unimpaired",         event = { "VeryLazy" } },
  { "b0o/incline.nvim",             event = { "WinEnter" }, config = true },
  {
    "simnalamburt/vim-mundo",
    event = { "VeryLazy" },
    keys = {
      { "<leader>um", vim.cmd.MundoToggle, desc = "Undo Tree" }
    },
  },
  { "kevinhwang91/nvim-bqf",         event = { "VeryLazy" } },
  { "folke/which-key.nvim",          config = true,                          lazy = true },
  { "tpope/vim-vinegar",             lazy = true,                            keys = { "-" } },
  { "radenling/vim-dispatch-neovim", dependencies = { "tpope/vim-dispatch" } },
  {
    "tpope/vim-rails",
    dependencies = { "radenling/vim-dispatch-neovim", "tpope/vim-bundler" },
    config = function()
      -- disable autocmd set filetype=eruby.yaml
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "eruby.yaml",
        callback = function() vim.bo.filetype = 'yaml' end
      })
    end
  },
  {
    "catppuccin/nvim",
    config = requirePlugin('catppuccin'),
    build = ":CatppuccinCompile",
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  { "folke/noice.nvim",          dependencies = { "MunifTanjim/nui.nvim" }, config = requirePlugin('noice') },
  {
    "simrat39/symbols-outline.nvim",
    config = true,
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" }
  },
  { "nvim-lualine/lualine.nvim", config = requirePlugin('lualine'),         dependencies = { "folke/noice.nvim" } },
  { "kdheepak/tabline.nvim",     config = requirePlugin('tabline'),         event = { "BufWinEnter" },            enabled = false },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Ggrep", "Gwrite", "Gread", "Gdiffsplit", "GBrowse", "GDelete" },
    dependencies = { "tpope/vim-rhubarb" }
  },
  {
    "rhysd/git-messenger.vim",
    config = function() vim.g.git_messenger_no_default_mappings = true end,
    lazy = true,
    keys = { { '<leader>m', "<Plug>(git-messenger)", desc = "Git Float" } }
  },
  {
    "lewis6991/gitsigns.nvim",
    config = requirePlugin('gitsigns'),
    event = "BufReadPre"
  },
  {
    "akinsho/toggleterm.nvim",
    tag = "2.3.0",
    config = requirePlugin('toggleterm'),
    keys = {
      { "<tab>",   desc = "Open terminal (float)" }, { "<C-t>", desc = "Open terminal (vsplit)" },
      { "<C-S-t>", desc = "Open terminal (new tab)" }, { "<leader>g", vim.cmd.ToggleLazyGit, desc = "Open LazyGit" }
    }
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
  {
    "rcarriga/nvim-notify",
    config = requirePlugin('nvim-notify'),
    keys = { { "<leader>fn", curry(vim.cmd.Telescope, "notify"), desc = "Notifications" } }
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "0.1.x",
    lazy = true,
    keys = {
      { '<leader>ff', curryRequire("telescope.builtin", "find_files"), desc = "Files" },
      { '<leader>fb', curryRequire("telescope.builtin", "buffers"),    desc = "Buffers" },
      { '<leader>fg', curryRequire("telescope.builtin", "live_grep"),  desc = "Grep" },
      { '<leader>fs', curryRequire("telescope.builtin", "treesitter"), desc = "Treesitter" },
      { '<leader>fh', curryRequire("telescope.builtin", "help_tags"),  desc = "Help" },
      { '<leader>fQ', curryRequire("telescope.builtin", "quickfix"),   desc = "Quickfix" },
      { '<leader>fr', curryRequire("telescope.builtin", "registers"),  desc = "Registers" },
      { '<leader>fR', curryRequire("telescope.builtin", "resume"),     desc = "Resume" },
    },
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make",
    config = curryRequire("telescope", "load_extension", "fzf"),
    event = { "BufWinEnter" }
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = requirePlugin('telescope-project'),
    lazy = true,
    keys = {
      { "<leader>p", curryRequire("telescope", { "extensions", "project", "project" }), desc = "Open Project" }
    }
  },
  --"lukas-reineke/indent-blankline.nvim",

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require 'plugins.lsp-config' end,
    dependencies = { "folke/neodev.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre" },
  },
  {
    "ErichDonGubler/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require("lsp_lines").setup()
    end,
    event = { "BufReadPre" },
  },

  { "folke/neodev.nvim", config = true, lazy = true },
  { "L3MON4D3/LuaSnip",  lazy = true },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = requirePlugin('nvim-cmp'),
    event = { "BufWinEnter" }
  },
  {
    "onsails/lspkind.nvim",
    lazy = true,
    config = requirePlugin('lspkind')
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
    end,
  },

  {
    "hrsh7th/cmp-buffer",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    event = { "InsertEnter" },
    config = requirePlugin('cmp-buffer')
  },

  {
    "smjonas/inc-rename.nvim",
    config = requirePlugin('increname'),
    cmd = "IncRename"
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = requirePlugin('nvim-treesitter'),
    build = ":TSUpdate",
    event = { "BufReadPost" },
  },

  {
    "mfussenegger/nvim-dap",
    config = requirePlugin('nvim-dap'),
    lazy = true,
    keys = {
      ---@diagnostic disable-next-line: missing-parameter
      { 'K',     function() if require("dap").session() then require("dapui").eval() else vim.lsp.buf.hover() end end },
      ---@diagnostic disable-next-line: missing-parameter
      {
        'K',
        curryRequire("dapui", "eval"),
        mode =
        "v"
      },
      { '<F10>', curryRequire("dap", "step_over") },
      { '<F11>', curryRequire("dap", "step_into") },
      { '<F12>', curryRequire("dap", "step_out") },
      { '<F5>', function()
        require('dapui').open({}); require('dap').continue()
      end },
      { '<F6>', curryRequire("dap", "run_last") },
      { '<F7>', function()
        require('dapui').close({}); require('dap').terminate()
      end },
      {
        '<leader>dr',
        function() require("dap").repl.open() end,
        desc =
        "Open repl"
      },
      {
        '<leader>db',
        function() require("dap").toggle_breakpoint() end,
        desc =
        "Toggle breakpoint"
      },
      {
        '<leader>dl',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        desc = "Log Message"
      },
      {
        '<leader>dL',
        function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc = "Breakpoint Condition"
      },
    }
  },
  { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" }, lazy = true },
  { "rcarriga/nvim-dap-ui",            dependencies = { "mfussenegger/nvim-dap" }, lazy = true },
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
    config = curryRequire("telescope", "load_extension", "dap"),
    lazy = true,
    keys = {
      { '<leader>df', curryRequire('telescope', { "extensions", "dap", "frames" }),           desc = "Frames" },
      { '<leader>dd', curryRequire('telescope', { "extensions", "dap", "commands" }),         desc = "Commands" },
      { '<leader>dB', curryRequire('telescope', { "extensions", "dap", "list_breakpoints" }), desc = "Breakpoints" },
      { '<leader>dv', curryRequire('telescope', { "extensions", "dap", "variables" }),        desc = "Variables" },
    }
  },
})

require('plugins.vim-slash')
