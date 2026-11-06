return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          always_show_bufferline = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true, -- Add separator line
            },
          },
          -- Additional helpful options
          separator_style = "slant", -- or "thick", "thin", "padded_slant"
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
        },
        highlights = {
          -- Optional: customize colors to match your theme
          offset_separator = {
            fg = "#3c3836", -- adjust to match your colorscheme
            bg = "#282828",
          },
        },
      })
    end,
  }
}
