local Plugin = {'nvim-treesitter/nvim-treesitter'}

Plugin.main = 'nvim-treesitter.configs'

Plugin.dependencies = {
  {'nvim-treesitter/nvim-treesitter-textobjects'}
}

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
    'vim',
    'vimdoc',
  },
}

return Plugin

