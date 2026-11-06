-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    -- Configure diagnostics globally for PHP files
    vim.diagnostic.config({
      sources = {
        phpcs = false,
      }
    })
  end,
})

-- Disable diagnostics on file open
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 }) -- disable diagnostics for current buffer
  end,
})
-- vim.api.nvim_create_autocmd("BufEnter", {
--  callback = function()
--    vim.diagnostic.disable(0) -- Disable for current buffer
--  end,
-- })

-- Identations
local indent_group = vim.api.nvim_create_augroup("IndentSettings", { clear = true })

-- PHP indentation
vim.api.nvim_create_autocmd("FileType", {
  group = indent_group,
  pattern = "php",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})
-- Disable Vim's built-in syntax highlighting for PHP
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    -- Disable PHP built-in variables highlight
    vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Normal" })
    -- Soften comments color
    vim.api.nvim_set_hl(0, "@comment", { fg = "#888888", italic = true })
    -- Neutralize PHPDoc annotation highlight
    vim.api.nvim_set_hl(0, "@attribute.phpdoc", { link = "Normal" })
    -- Optional: Neutralize Constant highlight only for php files
    vim.api.nvim_set_hl(0, "Constant", { link = "Normal" })
    vim.api.nvim_set_hl(0, "@keyword.return", { link = "Normal" })
    -- Neutralize modifier keywords color (linked to Keyword)
    vim.api.nvim_set_hl(0, "Keyword", { link = "Normal" })
    -- Optional: neutralize all keyword highlights
    vim.api.nvim_set_hl(0, "@keyword", { link = "Normal" })
    -- Neutralize function keyword color
    vim.api.nvim_set_hl(0, "@keyword.function", { link = "Normal" })
    vim.api.nvim_set_hl(0, "@function.method.call", { link = "Normal" })
    vim.api.nvim_set_hl(0, "@type.phpdoc", {  fg = "#888888", italic = true })
    vim.api.nvim_set_hl(0, "@spell.php", {  fg = "#888888", italic = true })
    vim.api.nvim_set_hl(0, "@nospell.phpdoc", {  fg = "#888888", italic = true })
    vim.api.nvim_set_hl(0, "@attribute.phpdoc", {  fg = "#888888", italic = true })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.visualbell = false
    vim.opt.errorbells = false
    vim.cmd("set t_vb=")
  end,
})

-- Open neo-tree sidebar on startup and let resession restore the last file
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      require("neo-tree.command").execute({ action = "show", position = "left" })
    end)
  end,
})

-- Remove empty [No Name] buffers and stray directory buffers left on startup
vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    vim.defer_fn(function()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.fn.bufname(bufnr)
        local ft = vim.bo[bufnr].filetype
        local is_netrw = ft == "netrw" or (name ~= "" and vim.fn.isdirectory(name) == 1)
        local is_empty = name == "" and vim.bo[bufnr].buftype == "" and not vim.bo[bufnr].modified
        if is_netrw then
          pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
        elseif is_empty then
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          if #lines <= 1 and (lines[1] or "") == "" then
            pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
          end
        end
      end
    end, 100)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- Disable nvim-cmp in text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    local cmp = require("cmp")
    cmp.setup.buffer({ enabled = false })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    vim.lsp.stop_client(vim.lsp.get_active_clients({ bufnr = 0 }))
  end,
})

-- Disable nvim-cmp autocomplete in text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    local ok, cmp = pcall(require, "cmp")
    if ok then
      cmp.setup.buffer({ enabled = false })
    end
  end,
})

-- Disable cmp autocomplete in text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    local ok, cmp = pcall(require, "cmp")
    if ok then
      cmp.setup.buffer({
        enabled = false, -- fully disables cmp
        sources = {},    -- also clear sources (spell, buffer, etc.)
      })
    end
  end,
})
-- Disable semantic highliting
--vim.api.nvim_create_autocmd("LspAttach", {
--  callback = function(args)
--    local client = vim.lsp.get_client_by_id(args.data.client_id)
--    if client then
--      client.server_capabilities.semanticTokensProvider = nil
--    end
--  end,
--})

--vim.api.nvim_create_autocmd("ColorScheme", {
--  callback = function()
    -- Get normal text color
--    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    
    -- Override all semantic highlights to use normal color
--    local semantic_prefixes = { "@lsp.type", "@lsp.mod" }
    
    -- Get all highlight groups
--    local all_groups = vim.fn.getcompletion("", "highlight")
    
--    for _, group in ipairs(all_groups) do
--      for _, prefix in ipairs(semantic_prefixes) do
--        if group:match("^" .. prefix) then
--          vim.api.nvim_set_hl(0, group, {
--            fg = normal.fg,
--            bg = normal.bg,
--            bold = false,
--            italic = false,
--          })
--        end
--      end
--    end
--  end,
--})

