return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.explorer = opts.explorer or {}
    opts.explorer.enabled = false
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.enabled = false
    return opts
  end,
}
