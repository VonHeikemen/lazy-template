local Plugin = {'mason-org/mason.nvim'}

Plugin.lazy = false

-- Last version that supports Neovim v0.9
Plugin.tag = 'v1.11.0'
Plugin.pin = true

-- See :help mason-settings
Plugin.opts = {
  ui = {border = 'rounded'}
}

return Plugin

