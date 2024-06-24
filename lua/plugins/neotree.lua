local Plugin = {'nvim-neo-tree/neo-tree.nvim'}

Plugin.branch = 'v3.x'

Plugin.lazy = false

Plugin.dependencies = {
  'MunifTanjim/nui.nvim',
  {'nvim-lua/plenary.nvim', build = false},
}

function Plugin.init()
  -- disable netrw (neovim's default file explorer)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

function Plugin.config()
  vim.keymap.set('n', '<leader>e', '<cmd>Neotree filesystem toggle<cr>', {desc = 'Toggle file explorer'})

  require('neo-tree').setup({})
end

return Plugin

