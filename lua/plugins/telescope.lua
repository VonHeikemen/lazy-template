local Plugin = {'nvim-telescope/telescope.nvim'}
local is_unix = vim.fn.has('unix') == 1 or vim.fn.has('mac') == 1

Plugin.branch = '0.1.x'

Plugin.build = false

Plugin.dependencies = {
  {'nvim-lua/plenary.nvim', build = false},
  {'natecraddock/telescope-zf-native.nvim', build = false},
}

Plugin.cmd = {'Telescope'}

function Plugin.init()
  -- See :help telescope.builtin
  vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>', {desc = 'Search file history'})
  vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>', {desc = 'Search open files'})
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {desc = 'Search all files'})
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {desc = 'Search in project'})
  vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', {desc = 'Search diagnostics'})
  vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', {desc = 'Buffer local search'})
end

function Plugin.config()
  pcall(require('telescope').load_extension, 'zf-native')
end

return Plugin

