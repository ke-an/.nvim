return {
  "nvim-neorg/neorg",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Neorg",
  ft = "norg",
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default modules
        ["core.concealer"] = {}, -- Pretty icons
        ["core.dirman"] = { -- Directory management
          config = {
            workspaces = {
              notes = "~/neorg",
            },
            default_workspace = "notes",
          },
        },
      },
    })
  end,
}
