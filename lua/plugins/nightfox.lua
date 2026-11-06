--return {
--  {
--    "EdenEast/nightfox.nvim",
--    config = function()
      -- Set your preferred colorscheme variant, e.g., "nightfox", "dawnfox", "dayfox", "terafox", "carbonfox"
--      vim.cmd.colorscheme("dayfox")
--    end,
--  },
--}
return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- Set colorscheme first
      vim.cmd.colorscheme("dayfox")
      
      -- Then fix the highlights
      vim.schedule(function()
        -- Clear general syntax backgrounds
        vim.api.nvim_set_hl(0, "Constant", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "String", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Number", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Boolean", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Float", { bg = "NONE" })
        
        -- Clear treesitter backgrounds
        local treesitter_groups = {
          "@variable", "@variable.builtin", "@variable.parameter",
          "@function", "@function.call", "@function.method", "@function.method.call",
          "@operator", "@punctuation", "@punctuation.delimiter", "@punctuation.special",
          "@keyword", "@keyword.function", "@keyword.operator"
        }
        
        for _, group in ipairs(treesitter_groups) do
          vim.api.nvim_set_hl(0, group, { bg = "NONE" })
          vim.api.nvim_set_hl(0, group .. ".php", { bg = "NONE" })
        end
        
        -- Set cursorline as underline only
        vim.api.nvim_set_hl(0, "CursorLine", { 
          bg = "NONE",
          underline = true,
	  sp = "#c4a7e7"
        })

	-- Cursor colors
	vim.opt.guicursor = {
	  "n-v-c:block-Cursor",
	  "i-ci:ver25-Cursor",
	  "r-cr:hor20-Cursor",
	  "o:hor50-Cursor"
	}

	vim.api.nvim_set_hl(0, 'Cursor', { fg = 'NONE', bg = '#878787' })
	vim.api.nvim_set_hl(0, 'lCursor', { fg = 'NONE', bg = '#878787' })
	vim.api.nvim_set_hl(0, 'CursorIM', { fg = 'NONE', bg = '#878787' })

      end)
    end,
  },
}
