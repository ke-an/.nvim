return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.default_component_configs = vim.tbl_deep_extend("force", opts.default_component_configs or {}, {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰉖",
        folder_empty_open = "󰷏",
        default = "",
        highlight = "NeoTreeFileIcon",
        provider = function(icon, node, state)
          if node.type == "directory" then
            return nil
          end
          return ""
        end,
      },
      git_status = {
        symbols = {
          added     = "",
          modified  = "",
          deleted   = "",
          renamed   = "",
          untracked = "",
          ignored   = "",
          unstaged  = "",
          staged    = "",
          conflict  = "",
        },
      },
      modified = {
        symbol = "",
        highlight = "NeoTreeModified",
      },
    })

    for _, view in ipairs({ "filesystem", "buffers", "git_status" }) do
      opts[view] = opts[view] or {}
      opts[view].components = opts[view].components or {}
      opts[view].components.icon = function(config, node, state)
        return {}
      end
    end

    return opts
  end,
}
