return {
  "kristijanhusak/vim-dadbod-ui",
  config = function()
    -- Fix: force filetype to sql for query buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbui_query",
      callback = function()
        vim.bo.filetype = "sql"
      end,
    })

    -- Fix: patch to remove a/b label lines from buffer content
    local ok, buffers = pcall(require, "vim-dadbod-ui.buffers")
    if ok then
      local original_add_query = buffers.add_query

      buffers.add_query = function(name, query)
        original_add_query(name, query)
        local buf = buffers.items[#buffers.items]
        if buf and buf.type == "query" and type(buf.lines) == "table" then
          buf.lines = vim.tbl_filter(function(line)
            return not (line:match("^%a$"))
          end, buf.lines)
        end
      end
    end
  end,
}

