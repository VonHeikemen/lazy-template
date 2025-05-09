local Plugin = {'mason-org/mason.nvim'}

Plugin.lazy = false

if vim.fn.has('nvim-0.11') == 0 then
  -- Last version that supports Neovim v0.9
  Plugin.tag = 'v1.11.0'
  Plugin.pin = true
end

-- See :help mason-settings
Plugin.opts = {
  ui = {border = 'rounded'}
}

return Plugin

