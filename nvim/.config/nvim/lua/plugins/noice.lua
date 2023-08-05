require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  --cmdline = {
  --  view = "cmdline",
  --},
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename = true, -- enables an input dialog for inc-rename.nvim
    --  lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  -- messages = {
  --   view = "messages", -- default view for messages, e.g. !ls
  --   enter = true,
  -- },
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
    --     kind = "",
    --     find = "written$",
    --   },
    --   opts = { skip = true },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = "line less;",
    --   },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = "more line;",
    --   },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = "fewer lines;",
    --   },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = "more lines;",
    --   },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = "^Already at oldest change",
    --   },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = "^Already at newest change",
    --   },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = "lines yanked$",
    --   },
    -- },
    -- {
    --   view = 'notify',
    --   filter = {
    --     event = "msg_show",
    --     kind = "",
    --     find = " change;",
    --   },
    -- },
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
  },
})
