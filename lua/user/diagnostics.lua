local levels = vim.diagnostic.severity
local opts = {
  virtual_text = true,
  float = {
    border = 'rounded',
  },
  signs = {
    text = {
      [levels.ERROR] = '✘',
      [levels.WARN] = '▲',
      [levels.HINT] = '⚑',
      [levels.INFO] = '»',
    },
  },
}

local function sign_define(name, text)
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, {
    texthl = hl,
    text = text,
    numhl = ''
  })
end

-- Ensure compatiblity with older Neovim versions
if vim.fn.has('nvim-0.11') == 0 then
  sign_define('Error', opts.signs.text[levels.ERROR])
  sign_define('Warn', opts.signs.text[levels.WARN])
  sign_define('Hint', opts.signs.text[levels.HINT])
  sign_define('Info', opts.signs.text[levels.INFO])

  vim.keymap.set('n', '<C-w>d', '<cmd>lua vim.diagnostic.open_float()<cr>')
  vim.keymap.set('n', '<C-w><C-d>', '<cmd>lua vim.diagnostic.open_float()<cr>')
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
end

vim.diagnostic.config(opts)

