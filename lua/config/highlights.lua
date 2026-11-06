vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    -- Override the global group used by @variable.builtin.php
    vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Normal" })
  end,
})

