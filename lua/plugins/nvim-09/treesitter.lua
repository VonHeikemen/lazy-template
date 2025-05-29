local Plugin = {'nvim-treesitter/nvim-treesitter'}

Plugin.main = 'nvim-treesitter.configs'
Plugin.branch = 'master'
Plugin.lazy = false

Plugin.dependencies = {
  {'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master'}
}

Plugin.build = ':TSUpdate'

-- See :help nvim-treesitter-modules
Plugin.opts = {
  auto_install = true,

  highlight = {
    enable = true,
  },

  -- :help nvim-treesitter-textobjects-modules
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },

  ensure_installed = {
    'lua',
    'vim',
    'vimdoc',
  },
}

return Plugin

