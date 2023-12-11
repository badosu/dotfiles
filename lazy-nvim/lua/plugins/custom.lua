local Util = require("lazyvim.util")

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
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "telescope.nvim",
      },
    },
    keys = {
      {
        "<leader>su",
        "<cmd>Telescope undo<cr>",
        desc = "Search undo tree",
      },
    },
    config = function()
      require("telescope").load_extension("undo")
    end,
  },
  {
    "telescope.nvim",
    -- dependencies = {
    --   {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     build = "make",
    --     config = function()
    --       require("telescope").load_extension("fzf")
    --     end,
    --   },
    -- },
    keys = {
      {
        "<leader>sG",
        function()
          vim.ui.input({ completion = "file", prompt = "Enter file or folder" }, function(input)
            if input ~= nil then
              Util.telescope("live_grep", { cwd = input })()
            end
          end)
        end,
        desc = "Grep (ask dir)",
      },
    },
    opts = {
      defaults = {
        preview = {
          treesitter = {
            disable = { "lua" },
          },
        },
        mappings = {
          i = {
            ["<c-t>"] = "select_tab",
          },
        },
      },
    },
  },
  {
    "almo7aya/openingh.nvim",
    event = "VeryLazy",
  },
  {
    "abecodes/tabout.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "L3MON4D3/LuaSnip",
    -- stylua: ignore
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          return luasnip.jumpable(1) and luasnip.jump(1) or fallback()
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          return luasnip.jumpable(-1) and luasnip.jump(-1) or fallback()
        end, { "i", "s" }),
      })
    end,
  },
  {
    "radenling/vim-dispatch-neovim",
    dependencies = { "tpope/vim-dispatch" },
    event = "VeryLazy",
  },
  {
    "tpope/vim-bundler",
    event = "VeryLazy",
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
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    keys = {
      {
        "<leader>gS",
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
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     local dap = require("dap")

  --     dap.adapters.mix_task = {
  --       type = "executable",
  --       command = "/home/badosu/.local/share/nvim/mason/bin/elixir-ls-debugger",
  --       args = {},
  --     }

  --     dap.configurations.elixir = {
  --       {
  --         type = "mix_task",
  --         name = "phx.server",
  --         request = "launch",
  --         task = "phx.server",
  --         projectDir = "${workspaceFolder}",
  --       },
  --       {
  --         type = "mix_task",
  --         name = "mix test",
  --         task = "test",
  --         taskArgs = { "--trace" },
  --         request = "launch",
  --         startApps = true, -- for Phoenix projects
  --         projectDir = "${workspaceFolder}",
  --         requireFiles = {
  --           "test/**/test_helper.exs",
  --           "test/**/*_test.exs",
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "ahmedkhalf/project.nvim",
    keys = {
      {
        "<leader>p",
        "<cmd>Telescope projects<cr>",
        desc = "Search projects",
      },
    },
    opts = function(_, opts)
      opts.patterns = { "mix.exs", "Gemfile" }
      vim.list_extend(opts.patterns, require("project_nvim.config").defaults.patterns)
    end,
  },
  {
    "rebelot/terminal.nvim",
    keys = {
      {
        "\\t",
        "<cmd>TermToggle<cr>",
        desc = "Toggle terminal panel",
      },
    },
    config = true,
  },
  -- {
  --   "pwntester/octo.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = true,
  -- },
}
