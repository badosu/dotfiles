local g = vim.g

vim.opt.termguicolors = true

g.git_messenger_no_default_mappings = true

vim.opt.shortmess = ""

vim.notify = require("notify")

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  cmdline = {
    view = "cmdline",
  },
  -- you can enable a preset for easier configuration
  presets = {
  --  bottom_search = true, -- use a classic bottom cmdline for search
  --  command_palette = true, -- position the cmdline and popupmenu together
  --  long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = true, -- enables an input dialog for inc-rename.nvim
  --  lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  routes = {
    --{
    --  filter = {
    --    event = "msg_show",
    --    kind = "",
    --    find = "[Modified]",
    --  },
    --  opts = { skip = true },
    --},
    {
      filter = {
        event = "msg_show",
        find = "^E38[45]",
      },
      opts = { skip = true },
    },
    { -- filter out search errors: also E486 PATTERN NOT FOUND
      filter = {
        event = "msg_show",
        find = "^E486",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        kind = "quickfix",
      },
      opts = { skip = true },
    },
    -- {
    --   filter = {
    --     event = "msg_show",
    --     kind = "echo",
    --   },
    --   opts = { skip = true },
    -- },
    -- {
    --   filter = {
    --     event = "msg_show",
    --     kind = "echomsg",
    --   },
    --   opts = { skip = true },
    -- },
    -- {
    --   filter = {
    --     event = "msg_show",
    --     kind = "echoerr",
    --   },
    --   opts = { skip = true },
    -- },
      -- "echo"		|:echo| message
      -- "echomsg"	|:echomsg| message
      -- "echoerr"	|:echoerr| message
  },
})

require'tabline'.setup {
  -- Defaults configuration options
  enable = true,
  options = {
--  -- If lualine is installed tabline will use separators configured in lualine by default.
--  -- These options can be used to override those settings.
--    --section_separators = {'', ''},
--    --component_separators = {'', ''},
--    --max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
--    --show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
--    --show_devicons = true, -- this shows devicons in buffer section
--    --show_bufnr = false, -- this appends [bufnr] to buffer section,
--    --show_filename_only = false, -- shows base filename only instead of relative path in filename
--    --modified_icon = "+ ", -- change the default modified icon
--    modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
--    show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
  }
}
vim.cmd[[
  set guioptions-=e " Use showtabline in gui vim
  set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]

local function qf_rename()
    local position_params = vim.lsp.util.make_position_params()
    position_params.oldName = vim.fn.expand("<cword>")
    position_params.newName = vim.fn.input("Rename To> ", position_params.oldName)

    vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, result, ...)
    end)
end
vim.lsp.buf.rename = qf_rename

local function foreach(tbl, f)
    if not tbl then return nil end

    local t = {}
    for key, value in pairs(tbl) do t[key] = f(value) end
    return t
end

local function qf_populate(lines, mode, title)
  if mode == nil or type(mode) == "table" then
    lines = foreach(lines, function(item) return { filename = item, lnum = 1, col = 1, text = item } end)
    mode = "r"
  end

  vim.fn.setqflist(lines, mode)

  if not title then
    vim.cmd [[
    belowright copen
    wincmd p
    ]]
  else
    vim.cmd(string.format("belowright copen\n%s\nwincmd p",
    require('statusline').set_statusline_cmd(title)))
  end
end

require("inc_rename").setup({
  post_hook = function(result)
    local entries = {}
    local num_files, num_updates = 0, 0
    for uri, edits in pairs(result.changes) do
        num_files = num_files + 1
        local bufnr = vim.uri_to_bufnr(uri)

        for _, edit in ipairs(edits) do
            local start_line = edit.range.start.line + 1
            local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

            num_updates = num_updates + 1
            table.insert(entries, {
                bufnr = bufnr,
                lnum = start_line,
                col = edit.range.start.character + 1,
                text = line
            })
        end
    end

    if num_files > 1 then qf_populate(entries, "r") end
  end
})

require("lualine").setup({
  sections = {
    lualine_x = {
      --{
      --  require("noice").api.status.message.get_hl,
      --  cond = require("noice").api.status.message.has,
      --},
      --{'encoding', 'fileformat', 'filetype'},
      {'filetype'},
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.search.get,
        cond = require("noice").api.status.search.has,
        color = { fg = "#ff9e64" },
      },
    },
  },
})

-- local ns = vim.api.nvim_create_namespace('notify_ns')
-- vim.ui_attach(ns, {ext_messages = true, ext_cmdline = false, ext_linegrid = false }, function(event, ...)
--     vim.notify(event .. "#\n" .. a .. "#\n" .. vim.inspect{...})
--   if event == 'msg_show' then
--     vim.notify(a)
--     vim.notify(vim.inspect{...})
--     return
--   end
--  end)

vim.api.nvim_command('set undofile')
vim.api.nvim_command('set undodir=~/.vim/undo')

require 'plugins/catppuccin'
require 'plugins/lsp-config'
require 'plugins/nvim-cmp'
require 'plugins/nvim-dap'
require 'plugins/telescope'
require 'plugins/gitsigns'

require('symbols-outline').setup()

require('lualine').setup({
  extensions = {'quickfix','fugitive','man','mundo','nvim-dap-ui','quickfix','symbols-outline','toggleterm'},--
})

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

require("toggleterm").setup({
  open_mapping = ",t",
})

-- vim.keymap.set('t', '<leader>T', ':ToggleTerm direction=float<CR>', opts)
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- ToggleTerm
--set('n', '<leader>t', ':ToggleTerm direction=float<CR>', ns)

--local Terminal  = require('toggleterm.terminal').Terminal
--local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
--
--function _lazygit_toggle()
--  lazygit:toggle()
--end
--
--vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
