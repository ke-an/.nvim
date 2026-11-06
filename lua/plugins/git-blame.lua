return {
  {
    "FabijanZulj/blame.nvim",
    event = "BufReadPost",
    config = function()
      require("blame").setup()

      -- Set the blame highlight
      vim.cmd [[
        hi BlameVirtText guifg=#bbbbbb guibg=NONE gui=bold
      ]]

      -- Map <leader>gb to toggle blame
      vim.api.nvim_set_keymap("n", "<leader>gb", ":BlameToggle<CR>", { noremap = true, silent = true })
    end,
  },
}

