return {
  "stevearc/resession.nvim",
  opts = {
    autosave = {
      enabled = true,
      interval = 300, -- autosave every 5 minutes
      notify = false,
    },
    dir = vim.fn.stdpath("state") .. "/sessions", -- ~/.local/state/nvim/sessions
    buf_filter = function(bufnr)
      local name = vim.fn.bufname(bufnr)
      return vim.bo[bufnr].buflisted
        and name ~= ""
        and vim.bo[bufnr].buftype == ""
        and vim.fn.isdirectory(name) == 0
        and vim.bo[bufnr].filetype ~= "netrw"
    end,
  },
  config = function(_, opts)
    local resession = require("resession")
    resession.setup(opts)

    -- Auto save on exit and load on start
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        resession.save(vim.fn.getcwd(), { notify = false })
      end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Only load if no files were passed
        if vim.fn.argc() == 0 then
          resession.load(vim.fn.getcwd(), { silence_errors = true })
        end
      end,
    })
  end,
}

