return {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false
      },
      telemetry = {
        enable = false
      },
    },
  },
  on_init = function(client)
    local uv = vim.uv or vim.loop
    local join = function(t) return table.concat(t, '/') end

    -- Don't do anything if there is a project local config
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      local luarc = (
        uv.fs_stat(join({path, '.luarc.json'}))
        or uv.fs_stat(join({path, '.luarc.jsonc'}))
      )

      if luarc then
        return
      end
    end

    local nvim_settings = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        checkThirdParty = false,
        library = {
          -- Make the server aware of Neovim runtime files
          vim.env.VIMRUNTIME,
        },
      },
    }

    client.config.settings.Lua = vim.tbl_deep_extend(
      'force',
      client.config.settings.Lua,
      nvim_settings
    )
  end,
}

