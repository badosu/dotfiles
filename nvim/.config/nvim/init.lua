require 'settings'
require 'keymaps'

require "paq" {
  'savq/paq-nvim';

  'folke/noice.nvim';
  'MunifTanjim/nui.nvim';
  'rcarriga/nvim-notify';

  'nvim-lua/plenary.nvim';
  {'akinsho/toggleterm.nvim', branch = '2.3.0' };

  {'nvim-telescope/telescope.nvim', branch = '0.1.x' };
  'nvim-telescope/telescope-dap.nvim';
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };
  'nvim-telescope/telescope-project.nvim';

  'simnalamburt/vim-mundo';

  'neovim/nvim-lspconfig';
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/cmp-vsnip';
  'hrsh7th/vim-vsnip';

  'smjonas/inc-rename.nvim';

  'kdheepak/tabline.nvim';

  'lewis6991/gitsigns.nvim';
  'kyazdani42/nvim-web-devicons';
  'tpope/vim-vinegar';
  'tpope/vim-unimpaired';
  'tpope/vim-rhubarb';
  'tpope/vim-fugitive';
  'rhysd/git-messenger.vim';
  'simrat39/symbols-outline.nvim';
  'nvim-lualine/lualine.nvim';
  'navarasu/onedark.nvim';
  { 'nvim-treesitter/nvim-treesitter', run = function() vim.cmd(':TSUpdate') end };

  --'sakhnik/nvim-gdb';
  'mfussenegger/nvim-dap';
  'theHamsta/nvim-dap-virtual-text';
  'rcarriga/nvim-dap-ui';
  'rcarriga/cmp-dap';

  'folke/neodev.nvim';
  'kevinhwang91/nvim-bqf';
}

require 'plugins'
