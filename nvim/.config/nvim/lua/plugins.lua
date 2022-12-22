require("lazy").setup({
  { "kyazdani42/nvim-web-devicons" },
  { "tpope/vim-vinegar" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-fugitive" },
  { "b0o/incline.nvim" },
  { "simnalamburt/vim-mundo" },
  { "kevinhwang91/nvim-bqf" },

  { "folke/trouble.nvim", config = function()
    local ns = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>xx", vim.cmd.TroubleToggle, ns)
    vim.keymap.set("n", "<leader>xw", function() vim.cmd.TroubleToggle("workspace_diagnostics") end, ns)
    vim.keymap.set("n", "<leader>xd", function() vim.cmd.TroubleToggle("document_diagnostics") end, ns)
    vim.keymap.set("n", "<leader>xl", function() vim.cmd.TroubleToggle("loclist") end, ns)
    vim.keymap.set("n", "<leader>xq", function() vim.cmd.TroubleToggle("quickfix") end, ns)
    vim.keymap.set("n", "gr",         function() vim.cmd.TroubleToggle("lsp_references") end, ns)
  end },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "0.1.x",
    config = function() require('plugins.telescope') end
  },
  { "nvim-telescope/telescope-fzf-native.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, build = "make" },
  { "nvim-telescope/telescope-project.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  { "nvim-telescope/telescope-dap.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

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

  { "akinsho/toggleterm.nvim", tag = "2.3.0", config = function() require('plugins.toggleterm') end },

  { "neovim/nvim-lspconfig", config = function() require 'plugins.lsp-config' end, dependencies = { "folke/neodev.nvim" } },

  { "L3MON4D3/LuaSnip", dependencies = { "hrsh7th/nvim-cmp" } },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require('plugins.nvim-cmp') end
  },

  { "smjonas/inc-rename.nvim", config = function() require('plugins.increname') end },

  { "kdheepak/tabline.nvim", config = function() require('plugins.tabline') end },

  { "lewis6991/gitsigns.nvim", config = function() require('plugins.gitsigns') end },

  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.api.nvim_set_keymap('n', '<leader>m', "<Plug>(git-messenger)", { noremap = true, silent = true })
    end
  },

  { "simrat39/symbols-outline.nvim", config = function() require('symbols-outline').setup() end },
  { "nvim-lualine/lualine.nvim", config = function() require('plugins.lualine') end, dependencies = { "folke/noice.nvim" } },
  { "nvim-treesitter/nvim-treesitter", config = function() require('plugins.nvim-treesitter') end, build = function() vim.cmd(":TSUpdate") end },

  { "mfussenegger/nvim-dap", config = function() require('plugins.nvim-dap') end, dependencies = { "nvim-telescope/telescope.nvim" } },
  { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  { "rcarriga/cmp-dap", dependencies = { "mfussenegger/nvim-dap" } },

  { "folke/neodev.nvim", config = function() require("neodev").setup() end },
})

require('plugins.vim-slash')
