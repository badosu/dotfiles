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
