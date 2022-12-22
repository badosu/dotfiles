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

vim.keymap.set("n", "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true })
