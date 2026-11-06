return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Xdebug inside a container: /var/www maps to the project opened in Neovim (cwd)
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug (/var/www)",
          port = 9003,
          pathMappings = {
            ["/var/www"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },
}
