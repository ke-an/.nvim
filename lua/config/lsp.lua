vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
    vim.keymap.set("n", "gr", function()
      Snacks.picker.lsp_references()
    end, { buffer = args.buf, nowait = true, desc = "LSP References" })
  end,
})

