local Util = require("lazyvim.util")

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
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
        winblend = 40,
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
      -- so that tabout can work
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end,
      })
    end,
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
  { "tiagovla/scope.nvim", config = true },
  {
    "echasnovski/mini.comment",
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = "<leader>ccx",

        -- Toggle comment on current line
        comment_line = "<leader>ccc",

        -- Toggle comment on visual selection
        comment_visual = "<leader>cc",

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- textobject = "gc",
      },
    },
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
