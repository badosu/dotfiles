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
    "williamboman/mason.nvim",
    opts = function(_, opts)
      for i, server in ipairs(opts.ensure_installed) do
        if server == "solargraph" then
          table.remove(opts.ensure_installed, i)

          break
        end
      end
    end,
  },
  --{
  --  "williamboman/mason-lspconfig.nvim",
  --  opts = function(_, opts)
  --    require("mason-lspconfig").setup(opts)

  --    require("mason-lspconfig").setup_handlers({
  --      -- The first entry (without a key) will be the default handler
  --      -- and will be called for each installed server that doesn't have
  --      -- a dedicated handler.
  --      function(server_name) -- default handler (optional)
  --        require("lspconfig")[server_name].setup({})
  --      end,
  --      -- Next, you can provide targeted overrides for specific servers.
  --      -- For example, a handler override for the rust_analyzer:
  --      ["solargraph"] = function()
  --        require("lspconfig").solargraph.setup({
  --          cmd = { "~/.asdf/shims/bundle", "exec", "solargraph", "stdio" },
  --          settings = {
  --            solargraph = {
  --              useBundler = true,
  --              bundlerPath = "~/.asdf/shims/bundle",
  --              checkGemVersion = false,
  --            },
  --          },
  --        })
  --      end,
  --    })
  --  end,
  --},
}
