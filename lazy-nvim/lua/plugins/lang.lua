return {
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
      -- config = function(_, opts)
      --   local lspconfig = require("lspconfig")
      --   for server, config in pairs(opts.servers) do
      --     -- passing config.capabilities to blink.cmp merges with the capabilities in your
      --     -- `opts[server].capabilities, if you've defined it
      --     config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      --     lspconfig[server].setup(config)
      --   end
      -- end,
      servers = {
        solargraph = {
          mason = false, -- set to false if you don't want this server to be installed with mason
        },
      },
      typst_lsp = function(_, opts)
        opts.settings = {
          exportPdf = "onSave", -- Choose onType, onSave or never.
        }
      end,
      -- we use eslint for formatting instead
      ts_ls = function(_, opts)
        opts.on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end,
      -- tailwindcss = function(_, opts)
      --   local util = require("lspconfig.util")

      --   opts.filetypes = {
      --     "css",
      --     "scss",
      --     "sass",
      --     "html",
      --     "heex",
      --     "elixir",
      --     "eelixir",
      --     "javascript",
      --     "javascriptreact",
      --     "typescript",
      --     "typescriptreact",
      --     "svelte",
      --   }

      --   opts.init_options = {
      --     userLanguages = {
      --       elixir = "phoenix-heex",
      --       eelixir = "phoenix-heex",
      --       heex = "phoenix-heex",
      --       eruby = "erb",
      --       svelte = "html",
      --       rust = "html",
      --     },
      --   }
      --   opts.settings = {
      --     -- includeLanguages = {
      --     --   typescript = "javascript",
      --     --   typescriptreact = "javascript",
      --     --   ["html-eex"] = "html",
      --     --   ["phoenix-heex"] = "html",
      --     --   heex = "html",
      --     --   eelixir = "html",
      --     --   elixir = "html",
      --     --   elm = "html",
      --     --   erb = "html",
      --     --   svelte = "html",
      --     --   rust = "html",
      --     -- },
      --     tailwindCSS = {
      --       includeLanguages = {
      --         elixir = "phoenix-heex",
      --         eelixir = "phoenix-heex",
      --         heex = "phoenix-heex",
      --       },
      --       experimental = {
      --         -- classRegex = {
      --         --   'class[:]\\s*"([^"]*)"',
      --         -- },
      --         classRegex = {
      --           [[class= "([^"]*)]],
      --           [[class: "([^"]*)]],
      --           '~H""".*class="([^"]*)".*"""',
      --           '~F""".*class="([^"]*)".*"""',
      --         },
      --       },
      --     },
      --   }
      --   --

      --   opts.root_dir = function(fname)
      --     return util.root_pattern(
      --       "tailwind.config.js",
      --       "tailwind.config.cjs",
      --       "tailwind.config.mjs",
      --       "tailwind.config.ts",
      --       "postcss.config.js",
      --       "postcss.config.cjs",
      --       "postcss.config.mjs",
      --       "postcss.config.ts",
      --       "mix.exs",
      --       "Gemfile"
      --     )(fname) or util.find_package_json_ancestor(fname) or util.find_node_modules_ancestor(fname) or util.find_git_ancestor(
      --       fname
      --     )
      --   end
      -- end,
    },
  },
}
