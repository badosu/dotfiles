return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        eruby = { "erb_format" },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- opts.highlight = vim.tbl_extend("force", opts.highlight or {}, {
      --   cond = function(lang, bufnr) -- Disable in large C++ buffers
      --     return not (lang == "lua") -- and vim.api.nvim_buf_line_count(bufnr) > 1000)
      --   end,
      -- })

      highlight = {
        disable = function(lang, buf)
          if lang ~= "lua" then
            return false
          end

          return vim.api.nvim_buf_line_count(buf) > 1000

          -- local max_filesize = 50 * 1024 -- 50 KB
          -- local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          -- if ok and stats and stats.size > max_filesize then
          --   return true
          -- end
        end,
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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {
          mason = false, -- set to false if you don't want this server to be installed with mason
        },
      },
    },
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")

      local lsp_capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        credo = { enable = true }, -- already handled by nextls
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
            enableTestLenses = false,
          }),
          -- root_dir = require("lspconfig.util").root_pattern("mix.exs"),
          -- root_dir = "~/Code/edge/checkout/",
          on_attach = function()
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        nextls = {
          enable = false,
          -- port = 9000, -- connect via TCP with the given port. mutually exclusive with `cmd`. defaults to nil
          -- cmd = "path/to/next-ls", -- path to the executable. mutually exclusive with `port`
          --   root_dir = function(fname)
          --     local util = require("lspconfig.util")

          --     vim.print("hauehuaehueahu ???")

          --     return util.root_pattern("mix.exs")(fname) or util.find_git_ancestor(fname) or vim.loop.os_homedir()
          --   end,
          init_options = {
            mix_env = "dev",
            mix_target = "host",
            experimental = {
              completions = {
                enable = true, -- control if completions are enabled. defaults to false
              },
            },
          },
          capabilities = lsp_capabilities,
          -- on_attach = function(client, bufnr)
          --   vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          --   vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          --   vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          -- end,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      for i, server in ipairs(opts.ensure_installed) do
        if server == "solargraph" then
          table.remove(opts.ensure_installed, i)
        end

        if server == "elixir-ls" then
          table.remove(opts.ensure_installed, i)
        end
      end
    end,
  },
  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    config = function()
      require("output_panel").setup()
    end,
  },
}
