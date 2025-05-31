local lazy = {}

function lazy.install(path)
  local uv = vim.uv or vim.loop
  if not uv.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
    print('Done.')
  end
end

function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
end

lazy.path = table.concat({
  vim.fn.stdpath('data') --[[@as string]],
  'lazy',
  'lazy.nvim'
}, '/')

lazy.opts = {
  ui = {
    border = 'rounded',
  },
  install = {
    missing = true,  -- install missing plugins on startup.
  },
  change_detection = {
    enabled = false, -- check for config file changes
    notify = false,  -- get a notification when changes are found
  },
}

-- include all configurations from lua/plugins/* folder
-- note: files in nested folders are not included by default (which is good)
local plugins = {{import = 'plugins'}}

if vim.fn.has('nvim-0.11') == 1 then
  -- include plugins in lua/plugins/nvim-011/*
  -- these are not compatible with older versions of neovim
  table.insert(plugins, {import = 'plugins.nvim-011'})
else
  -- include plugins in lua/plugins/nvim-09/*
  -- these are pinned to a version that still work on nvim v0.9 and v0.10
  table.insert(plugins, {import = 'plugins.nvim-09'})
end

lazy.setup(plugins)

