-- IMPORTANT: tree-sitter CLI is needed
-- https://github.com/tree-sitter/tree-sitter

local Plugin = {'nvim-treesitter/nvim-treesitter'}

Plugin.branch = 'main'
Plugin.build = ':TSUpdate'
Plugin.lazy = false

function Plugin.config()
  -- NOTE: the list of supported parsers is the documentation:
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
  local parsers = {'lua', 'vim', 'vimdoc'}
  local group = vim.api.nvim_create_augroup('treesitter_cmds', {clear = true})

  local ts = vim.treesitter
  local filetypes = vim.iter(parsers)
    :map(ts.language.get_filetypes)
    :flatten()
    :fold({}, function(tbl, v)
      tbl[v] = true
      return tbl
    end)

  require('nvim-treesitter').install(parsers)

  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    desc = 'enable treesitter',
    callback = function(event)
      local ft = event.match
      if filetypes[ft] == nil then
        return
      end

      local lang = ts.language.get_lang(ft)
      local ok, hl = pcall(ts.query.get, lang, 'highlights')

      if ok and hl then
        ts.start(event.buf, lang)
      end
    end,
  })
end

return Plugin

