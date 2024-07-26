local Util = require("lazyvim.util")

return {
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     restricted_keys = {
  --       ["-"] = {},
  --     },
  --     disabled_filetypes = {
  --       "qf",
  --       "netrw",
  --       "NvimTree",
  --       "lazy",
  --       "mason",
  --       "oil",
  --       "neotest-summary",
  --       "neotest-output-panel",
  --     },
  --   },
  -- },
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
    lazy = false,
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.enabled = function()
        local disabled = false
        disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
        disabled = disabled or (vim.fn.reg_recording() ~= "")
        disabled = disabled or (vim.fn.reg_executing() ~= "")

        if disabled then
          return false
        end

        -- keep command mode completion enabled
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          -- disable completion inside strings
          local context = require("cmp.config.context")
          return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
        end
      end

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
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
