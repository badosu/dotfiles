return {
  {
    "stevearc/oil.nvim",
    keys = {
      {
        "-",
        "<cmd>Oil<cr>",
        desc = "Explore parent directory",
      },
    },
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>gt",
        "<cmd>DiffviewToggleFiles<cr>",
        desc = "Toggle Diff Files Panel",
      },
      {
        "<leader>gd",
        "<cmd>DiffviewOpen<cr>",
        desc = "Open Diff View",
      },
    },
    opts = {
      view = {
        merge_tool = {
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see ':h diffview-config-view.x.layout'.
          layout = "diff3_horizontal",
        },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional
    },
    keys = {
      {
        "<leader>gg",
        "<cmd>Neogit<cr>",
        desc = "Neogit status",
      },
      {
        "<leader>gm",
        "<cmd>NeogitMessages<cr>",
        desc = "Neogit Messages",
      },
    },
    config = true,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    enabled = false,
    -- stylua: ignore
    keys = {
      { "<leader>td",
        function()
          require("neotest").run.run({strategy = "integrated", suite = false})
        end,
        desc = "Debug Nearest 1"
      },
    },
  },
  -- {
  --   "Saghen/blink.cmp",
  --   tag = "v0.7.6",
  -- },
}
