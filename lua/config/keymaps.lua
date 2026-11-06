-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function references_under_mouse()
  local mouse = vim.fn.getmousepos()
  if mouse.winid == 0 or not vim.api.nvim_win_is_valid(mouse.winid) or mouse.line < 1 then
    return
  end

  vim.api.nvim_set_current_win(mouse.winid)
  vim.api.nvim_win_set_cursor(mouse.winid, { mouse.line, math.max(mouse.column - 1, 0) })
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/references" })
  if #clients == 0 then
    vim.notify("No LSP reference provider is attached to this buffer", vim.log.levels.WARN)
    return
  end

  local params = vim.lsp.util.make_position_params(mouse.winid, "utf-16")
  params.context = { includeDeclaration = true }
  vim.lsp.buf_request_all(bufnr, "textDocument/references", params, function(responses)
    local locations = {}
    for _, response in pairs(responses) do
      for _, location in ipairs(response.result or {}) do
        table.insert(locations, location)
      end
    end

    vim.schedule(function()
      if #locations == 0 then
        vim.notify("No references found", vim.log.levels.INFO)
        return
      end

      local lines = { "References (Enter to open, Esc to close)" }
      for index, location in ipairs(locations) do
        local uri = location.uri or location.targetUri
        local range = location.range or location.targetSelectionRange or location.targetRange
        local path = vim.fn.fnamemodify(vim.uri_to_fname(uri), ":.")
        table.insert(lines, string.format("%d. %s:%d", index, path, range.start.line + 1))
      end

      local menu_buf = vim.api.nvim_create_buf(false, true)
      vim.bo[menu_buf].bufhidden = "wipe"
      vim.bo[menu_buf].swapfile = false
      vim.api.nvim_buf_set_lines(menu_buf, 0, -1, false, lines)
      vim.bo[menu_buf].modifiable = false
      local width = math.min(math.max(unpack(vim.tbl_map(vim.fn.strdisplaywidth, lines))) + 2, math.floor(vim.o.columns * 0.75))
      local height = math.min(#lines, 12)
      local menu_win = vim.api.nvim_open_win(menu_buf, true, {
        relative = "win", win = mouse.winid, row = mouse.winrow, col = mouse.wincol - 1,
        width = width, height = height, style = "minimal", border = "rounded",
      })
      vim.api.nvim_win_set_cursor(menu_win, { 2, 0 })

      local function close_menu()
        if vim.api.nvim_win_is_valid(menu_win) then vim.api.nvim_win_close(menu_win, true) end
      end
      local function open_reference()
        local selected = locations[vim.api.nvim_win_get_cursor(menu_win)[1] - 1]
        if not selected then return end
        close_menu()
        vim.api.nvim_set_current_win(mouse.winid)
        vim.lsp.util.show_document(selected, "utf-16", { focus = true })
      end
      vim.keymap.set("n", "<CR>", open_reference, { buffer = menu_buf, nowait = true })
      vim.keymap.set("n", "q", close_menu, { buffer = menu_buf, nowait = true })
      vim.keymap.set("n", "<Esc>", close_menu, { buffer = menu_buf, nowait = true })
    end)
  end)
end

vim.keymap.set("n", "<C-LeftMouse>", references_under_mouse, { desc = "LSP References", nowait = true })

--
vim.keymap.set("n", "gr", function()
  Snacks.picker.lsp_references()
end, { nowait = true, desc = "LSP References" })
vim.keymap.set("n", "<leader>p", function()
  -- build "file:line:col" string
  local pos = vim.fn.expand("%") .. ":" .. vim.fn.line(".") .. ":" .. vim.fn.col(".")
  -- copy to system clipboard
  vim.fn.setreg("+", pos)
  -- (optional) echo it so you see what got copied
  vim.notify("Copied: " .. pos, vim.log.levels.INFO)
end, { desc = "Copy file:line:col to clipboard" })

