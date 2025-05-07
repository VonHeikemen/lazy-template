local Plugin = {'williamboman/mason-lspconfig.nvim'}

Plugin.lazy = true

if vim.fn.has('nvim-0.11') == 0 then
  -- Last version that supports Neovim v0.10
  Plugin.tag = 'v1.32.0'
  Plugin.pin = true
end

-- See :help mason-lspconfig-settings
Plugin.opts = {}

return Plugin

