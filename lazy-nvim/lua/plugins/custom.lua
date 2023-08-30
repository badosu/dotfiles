return {
  {
    "stevearc/oil.nvim",
    keys = {
      {
        "-",
        "<cmd>Oil<cr>",
        desc = "Open parent directory",
      },
    },
    config = true,
  },
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<c-t>"] = "select_tab",
          },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          rspec_cmd = function()
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rspec",
            })
          end,
        },
      },
    },
    keys = {
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach",
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
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      require("mason-lspconfig").setup(opts)

      require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
        -- Next, you can provide targeted overrides for specific servers.
        -- For example, a handler override for the rust_analyzer:
        ["solargraph"] = function()
          require("lspconfig").solargraph.setup({
            cmd = { "~/.asdf/shims/bundle", "exec", "solargraph", "stdio" },
            settings = {
              solargraph = {
                useBundler = true,
                bundlerPath = "~/.asdf/shims/bundle",
                checkGemVersion = false,
              },
            },
          })
        end,
      })
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
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")

      table.insert(opts.sources, nls.builtins.formatting.erb_format)
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    config = true,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },

  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     local Config = require("lazyvim.config")
  --     vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  --     for name, sign in pairs(Config.icons.dap) do
  --       sign = type(sign) == "table" and sign or { sign }
  --       vim.fn.sign_define(
  --         "Dap" .. name,
  --         { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
  --       )
  --     end

  --     local dap = require("dap")

  --     dap.adapters.ruby = function(callback, config)
  --       local script

  --       if config.current_line then
  --         script = config.script .. ":" .. vim.fn.line(".")
  --       else
  --         script = config.script
  --       end

  --       callback({
  --         type = "server",
  --         host = "127.0.0.1",
  --         port = "${port}",
  --         executable = {
  --           command = "bundle",
  --           args = { "exec", "rdbg", "--open", "--port", "${port}", "-c", "--", config.command, script },
  --         },
  --       })
  --     end

  --     dap.configurations.ruby = {
  --       {
  --         type = "ruby",
  --         name = "debug rspec current_line",
  --         request = "attach",
  --         localfs = true,
  --         command = "bin/rspec",
  --         script = "${file}",
  --         current_line = true,
  --       },
  --       {
  --         type = "ruby",
  --         name = "debug current file",
  --         request = "attach",
  --         localfs = true,
  --         command = "ruby",
  --         script = "${file}",
  --       },
  --     }
  --   end,
  -- },
}
