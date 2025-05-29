local Plugin = {'mason-org/mason-lspconfig.nvim'}
Plugin.lazy = true

-- See :help mason-lspconfig-settings
Plugin.opts = {
  -- language servers will be enabled in
  -- lua/plugins/nvim-011/lspconfig.lua
  -- that's because lspconfig's migration to vim.lsp.enable()
  -- is not 100% complete. See:
  -- https://github.com/neovim/nvim-lspconfig/issues/3705
  automatic_enable = false,
}

return Plugin

