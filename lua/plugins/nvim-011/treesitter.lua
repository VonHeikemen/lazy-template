-- IMPORTANT: tree-sitter CLI is needed
-- https://github.com/tree-sitter/tree-sitter

local Plugin = {'nvim-treesitter/nvim-treesitter'}
local user = {}

Plugin.branch = 'main'
Plugin.build = ':TSUpdate'
Plugin.lazy = false

function Plugin.config()
  -- NOTE: the list of supported parsers is the documentation:
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
  local parsers = {'lua', 'vim', 'vimdoc'}

  local filetypes = user.map_filetypes(parsers)
  local group = vim.api.nvim_create_augroup('treesitter_cmds', {clear = true})

  require('nvim-treesitter').install(parsers)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    group = group,
    desc = 'enable treesitter syntax highlight',
    callback = function()
      vim.treesitter.start()
    end,
  })
end

function user.map_filetypes(parsers)
  local result = {}
  local get_filetypes = vim.treesitter.language.get_filetypes

  for _, parser in ipairs(parsers) do
    vim.list_extend(result, get_filetypes(parser))
  end

  return result
end

return Plugin

