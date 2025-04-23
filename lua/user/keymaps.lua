-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^', {desc = 'Go to first non-blank character'})
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_', {desc = 'Go to last non-blank character'})
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>', {desc = 'Select all text'})

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard content'})

-- Delete text without changing vim's internal registers
vim.keymap.set({'n', 'x'}, 'x', '"_x', {desc = 'Cut character'})
vim.keymap.set({'n', 'x'}, 'X', '"_d', {desc = 'Cut text'})

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save buffer'})
vim.keymap.set('n', '<leader>qq', '<cmd>quitall<cr>', {desc = 'Exit Neovim'})
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>', {desc = 'Close buffer and window'})
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>', {desc = 'Go to last active buffer'})

if vim.fn.has('nvim-0.11') == 0 then
  -- navigate between open buffers
  vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', {desc = ':bprevious'})
  vim.keymap.set('n', ']b', '<cmd>bnext<cr>', {desc = ':bnext'})
  vim.keymap.set('n', '[B', '<cmd>brewind<cr>', {desc = ':brewind'})
  vim.keymap.set('n', ']B', '<cmd>blast<cr>', {desc = ':blast'})

  -- navigate the quickfix list
  vim.keymap.set('n', '[q', '<cmd>cprevious<cr>', {desc = ':cprevious'})
  vim.keymap.set('n', ']q', '<cmd>cnext<cr>', {desc = ':cnext'})
  vim.keymap.set('n', '[Q', '<cmd>crewind<cr>', {desc = ':crewind'})
  vim.keymap.set('n', ']Q', '<cmd>clast<cr>', {desc = ':clast'})
end

