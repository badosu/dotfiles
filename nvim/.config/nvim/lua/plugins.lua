require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "0.1.x"
  },
  { "nvim-telescope/telescope-fzf-native.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, build = "make" },
  { "nvim-telescope/telescope-project.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  { "nvim-telescope/telescope-dap.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

  "catppuccin/nvim",
  --"lukas-reineke/indent-blankline.nvim",
  "b0o/incline.nvim",

  "rcarriga/nvim-notify",
  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },

  { "akinsho/toggleterm.nvim", tag = "2.3.0" },

  "simnalamburt/vim-mundo",

  "neovim/nvim-lspconfig",

  "hrsh7th/vim-vsnip",

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
    },
  },

  "folke/trouble.nvim",

  "smjonas/inc-rename.nvim",

  "kdheepak/tabline.nvim",

  "lewis6991/gitsigns.nvim",
  "kyazdani42/nvim-web-devicons",
  "tpope/vim-vinegar",
  "tpope/vim-unimpaired",
  "tpope/vim-rhubarb",
  "tpope/vim-fugitive",
  "rhysd/git-messenger.vim",
  "simrat39/symbols-outline.nvim",
  "nvim-lualine/lualine.nvim",
  --"navarasu/onedark.nvim",
  { "nvim-treesitter/nvim-treesitter", build = function() vim.cmd(":TSUpdate") end },

  "mfussenegger/nvim-dap",
  { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  { "rcarriga/cmp-dap", dependencies = { "mfussenegger/nvim-dap" } },

  "folke/neodev.nvim",
  "kevinhwang91/nvim-bqf",
})
