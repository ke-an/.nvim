-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.opt.guifont = "JetBrainsMono Nerd Font:h8"
-- vim.opt.guifont = "JetBrains Mono NL:h11"

-- Completely disable all floating diagnostics
vim.diagnostic.config({
  virtual_text = false
})
-- Completely disable LSP hover
vim.lsp.handlers["textDocument/hover"] = function() end

vim.cmd([[
  if !exists('s:message')
    let s:message = ''
  endif
]])

-- Smart indentation settings
vim.opt.autoindent = true      -- Copy indent from current line
vim.opt.smartindent = true     -- Smart autoindenting for C-like languages
vim.opt.cindent = true         -- More precise indenting for C-like languages

-- Tab settings
vim.opt.tabstop = 4           -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4        -- Number of spaces for each indentation
vim.opt.softtabstop = 4       -- Number of spaces tab key inserts
vim.opt.expandtab = true      -- Convert tabs to spaces

-- Smart tab behavior
vim.opt.smarttab = true       -- Smart tab behavior at beginning of line
vim.opt.shiftround = true     -- Round indent to multiple of shiftwidth

vim.opt.guifont = "Hack:h12"

-- Fix colorscheme dimming issues
-- Ensure syntax highlighting takes precedence over semantic tokens
vim.g.syntax_on = 1
vim.opt.termguicolors = true

-- COMPLETELY DISABLE SEMANTIC COLORING
-- Disable semantic tokens globally
vim.g.semantic_tokens_enabled = false
vim.g.semantic_highlighting = false

-- Clear any existing semantic token highlights
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Clear semantic token namespaces
    for _, ns_id in pairs(vim.api.nvim_get_namespaces()) do
      if type(ns_id) == "number" then
        vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
      end
    end
  end,
})

vim.opt.complete = ""
vim.opt.completeopt = ""
-- vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
