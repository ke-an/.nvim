return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      phpactor = {
        on_init = function(client, _)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      },
      intelephense = {
        on_init = function(client, _)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      },
      lua_ls = {
        on_init = function(client, _)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      },
      tsserver = {
        on_init = function(client, _)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      },
    },
  },
}
