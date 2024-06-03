---@diagnostic disable: inject-field
return {
  {
    "stevearc/conform.nvim",
    ---@param opts conform.FileFormatterConfig
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        eruby = { "erb_format" },
      })
      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        erb_format = {
          args = { "--single-class-per-line", "--stdin" },
          -- args = { "--stdin" },
        },
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
      "jfpedroza/neotest-elixir",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          rspec_cmd = function()
            return vim.iter({ "bundle", "exec", "rspec" }):flatten()
          end,
        },
        ["neotest-elixir"] = {},
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
        -- ---@type lspconfig.options.elixirls
        -- ---@diagnostic disable-next-line: missing-fields
        -- elixirls = {
        --   mason = false, -- set to false if you don't want this server to be installed with mason
        --   -- settings = {
        --   --   ---@diagnostic disable-next-line: missing-fields
        --   --   elixirLS = {
        --   --     autoInsertRequiredAlias = false, -- default is true
        --   --   },
        --   -- },
        -- },
      },
      setup = {
        -- we use eslint for formatting instead
        tsserver = function(_, opts)
          opts.on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
        tailwindcss = function(_, opts)
          local util = require("lspconfig.util")

          -- opts.filetypes = { "html", "elixir", "eelixir", "heex", "eruby" }

          -- opts.init_options = {
          --   userLanguages = {
          --     elixir = "html-eex",
          --     eelixir = "html-eex",
          --     heex = "html-eex",
          --     eruby = "erb",
          --   },
          -- }
          -- opts.settings = {
          --   tailwindCSS = {
          --     experimental = {
          --       -- classRegex = {
          --       --   'class[:]\\s*"([^"]*)"',
          --       -- },
          --       -- classRegex = {
          --       --   [[class= "([^"]*)]],
          --       --   [[class: "([^"]*)]],
          --       --   '~H""".*class="([^"]*)".*"""',
          --       --   '~F""".*class="([^"]*)".*"""',
          --       -- },
          --     },
          --   },
          -- }

          opts.root_dir = function(fname)
            return util.root_pattern(
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.mjs",
              "tailwind.config.ts",
              "postcss.config.js",
              "postcss.config.cjs",
              "postcss.config.mjs",
              "postcss.config.ts",
              "mix.exs",
              "Gemfile"
            )(fname) or util.find_package_json_ancestor(fname) or util.find_node_modules_ancestor(fname) or util.find_git_ancestor(
              fname
            )
          end
        end,
      },
    },
  },
  --{
  --  "elixir-tools/elixir-tools.nvim",
  --  version = "*",
  --  event = { "BufReadPre", "BufNewFile" },
  --  config = function()
  --    local elixir = require("elixir")
  --    local elixirls = require("elixir.elixirls")

  --    elixir.setup({
  --      nextls = { enable = true },
  --      credo = { enable = false },
  --      elixirls = {
  --        enable = false,
  --        settings = elixirls.settings({
  --          dialyzerEnabled = false,
  --          enableTestLenses = true,
  --        }),
  --        on_attach = function(_client, _bufnr)
  --          vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --          vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --          vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --        end,
  --      },
  --    })
  --  end,
  --  dependencies = {
  --    "nvim-lua/plenary.nvim",
  --  },
  --},
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
