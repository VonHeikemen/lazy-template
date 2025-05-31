-- IMPORTANT: tree-sitter CLI is needed
-- https://github.com/tree-sitter/tree-sitter

local Plugin = {'nvim-treesitter/nvim-treesitter'}
local user = {}

Plugin.branch = 'main'
Plugin.build = ':TSUpdate'
Plugin.lazy = false

function Plugin.config()
  -- NOTE: parser names and neovim filetypes sometimes are different
  -- the list of supported parsers is the documentation:
  -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages

  local parsers = {'lua', 'vim', 'vimdoc'}
  local filetypes = {'lua', 'vim', 'help'}

  user.ensure_installed(parsers)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    desc = 'enable treesitter syntax highlight',
    callback = function()
      vim.treesitter.start()
    end,
  })
end

function user.ensure_installed(parsers)
  local ts = require('nvim-treesitter')
  local installed_parsers = ts.get_installed()
  local missing = {}

  for _, parser in ipairs(parsers) do
    local installed = vim.tbl_contains(installed_parsers, parser)

    if not installed then
      table.insert(missing, parser)
    end
  end

  if not vim.tbl_isempty(missing) then
    ts.install(missing)
  end
end

return Plugin

