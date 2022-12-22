require("nvim-treesitter.configs").setup {
  ensure_installed = {"cmake", "make", "markdown", "rust", "dockerfile", "gitignore", "gitattributes", "git_rebase", "java", "elixir", "eex", "glsl", "c", "cpp", "json", "toml", "yaml", "python", "bash", "go", "css", "html", "typescript", "javascript", "ruby", "lua", "regex", "markdown_inline",},

  sync_install = false,
  auto_install = true,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldenable = false
