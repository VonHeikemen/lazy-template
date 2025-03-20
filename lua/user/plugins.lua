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

-- import plugins configs from lua/plugins/ folder
lazy.setup({{import = 'plugins'}})

