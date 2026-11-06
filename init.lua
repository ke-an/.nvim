-- Disable netrw before plugins load so neo-tree handles all directory navigation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.g.disable_autoformat = true
vim.opt.belloff = "all"
vim.opt.visualbell = true
vim.opt.errorbells = false
