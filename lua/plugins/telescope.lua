local Plugin = {'nvim-telescope/telescope.nvim'}
local is_unix = vim.fn.has('unix') == 1 or vim.fn.has('mac') == 1

Plugin.branch = '0.1.x'

Plugin.dependencies = {
  {'nvim-lua/plenary.nvim'},
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    enabled = is_unix
  },
}

Plugin.cmd = {'Telescope'}

function Plugin.init()
  -- See :help telescope.builtin
  vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
  vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
  vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
  vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
end

function Plugin.config()
  if is_unix then
    require('telescope').load_extension('fzf')
  end
end

return Plugin

