-- A collection of QoL plugins for Neovim
local Plugin = {'folke/snacks.nvim'}

Plugin.lazy = false

Plugin.opts = {
  indent = {
    enabled = true,
    char = '▏',
  },
  scope = {
    enabled = false,
  },
  toggle = {
    notify = false,
  },
  input = {
    enabled = true,
    icon = '❯',
  },
  explorer = {
    enabled = true,
    replace_netrw = true,
  },
  picker = {
    enabled = true,
    formatters = {
      file = {
        truncate = 78,
      },
    },
  },
  bigfile = {
    -- Only use `bigfile` module on older Neovim versions
    enabled = vim.fn.has('nvim-0.11') == 0,
    notify = false,
    size = 1024 * 1024, -- 1MB
    setup = function(ctx)
      vim.cmd('syntax clear')
      vim.opt_local.syntax = 'OFF'
      local buf = vim.b[ctx.buf]
      if buf.ts_highlight then
        vim.treesitter.stop(ctx.buf)
      end
    end
  },
}

function Plugin.config(_, opts)
  -- Disable indent guide animation
  vim.g.snacks_animate = false

  local Snacks = require('snacks')
  Snacks.setup(opts)

  -- Note: to learn the keymaps available inside a snack picker go to
  -- normal mode and press `?` to display the help window.
  -- Sadly, the help window will fail on Neovim v0.9.5

  -- File explorer
  -- docs: https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md
  -- Note: this explorer is also a "snack picker"
  vim.keymap.set('n', '<leader>e', '<cmd>lua Snacks.explorer()<cr>', {desc = 'File explorer'})

  -- Fuzzy finders
  -- docs: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
  vim.keymap.set('n', '<leader><space>', '<cmd>lua Snacks.picker("buffers")<cr>', {desc = 'Search open files'})
  vim.keymap.set('n', '<leader>ff', '<cmd>lua Snacks.picker("files")<cr>', {desc = 'Search all files'})
  vim.keymap.set('n', '<leader>fh', '<cmd>lua Snacks.picker("recent")<cr>', {desc = 'Search file history'})
  vim.keymap.set('n', '<leader>fg', '<cmd>lua Snacks.picker("grep")<cr>', {desc = 'Search in project'})
  vim.keymap.set('n', '<leader>fd', '<cmd>lua Snacks.picker("diagnostics")<cr>', {desc = 'Search diagnostics'})
  vim.keymap.set('n', '<leader>fs', '<cmd>lua Snacks.picker("lines")<cr>', {desc = 'Buffer local search'})
  vim.keymap.set('n', '<leader>u', '<cmd>lua Snacks.picker("undo")<cr>', {desc = 'Undo history'})
  vim.keymap.set('n', '<leader>/', '<cmd>lua Snacks.picker("pickers")<cr>', {desc = 'Search picker'})
  vim.keymap.set('n', '<leader>?', '<cmd>lua Snacks.picker("keymaps")<cr>', {desc = 'Search keymaps'})

  -- Toggle terminal window
  -- docs: https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md
  vim.keymap.set({'n', 't'}, '<C-g>', '<cmd>lua Snacks.terminal.toggle()<cr>', {desc = 'Toggle terminal'})

  -- Close buffer while preserving window layout
  -- docs: https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md
  vim.keymap.set('n', '<leader>bc', '<cmd>lua Snacks.bufdelete()<cr>', {desc = 'Close buffer'})

  -- Toggle indent guide lines
  vim.keymap.set('n', '<leader>ti', '<cmd>lua Snacks.toggle.indent():toggle()<cr>', {desc = 'Toggle indent guides'})
end

return Plugin

