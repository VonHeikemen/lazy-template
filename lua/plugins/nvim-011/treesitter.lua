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

  local ts = vim.treesitter
  local group = vim.api.nvim_create_augroup('treesitter_cmds', {clear = true})

  local filetypes = vim.iter(parsers)
    :map(ts.language.get_filetypes)
    :flatten()
    :fold({}, function(tbl, v)
      tbl[v] = 0
      return tbl
    end)

  local ts_enable = function(buffer, lang)
    local ok_hl, hl = pcall(ts.query.get, lang, 'highlights')
    if ok_hl and hl then
      ts.start(buffer, lang)
    end

    ---- Uncomment this block to enable folds
    -- local ok_fld, fld = pcall(ts.query.get, lang, 'folds')
    -- if ok_fld and fld then
    --   vim.wo.foldmethod = 'expr'
    --   vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- end

    ---- Uncomment this block to enable indents
    -- local ok_idt, idt = pcall(ts.query.get, lang, 'indents')
    -- if ok_idt and idt then
    --   vim.bo[buffer].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- end
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    desc = 'enable treesitter',
    callback = function(event)
      local ft = event.match
      local available = filetypes[ft]
      if available == nil then
        return
      end

      local lang = ts.language.get_lang(ft)
      local buffer = event.buf

      if lang == nil or lang == '' then
        return
      end

      if available == 0 and ts.language.add(lang) then
        available = 1
        filetypes[ft] = 1
      end

      if available == 1 then
        ts_enable(buffer, lang)
        return
      end

      require('nvim-treesitter').install(lang):await(function()
        local parser_installed = ts.language.add(lang) == true
        if not parser_installed then
          filetypes[ft] = nil
          return
        end

        filetypes[ft] = 1
        ts_enable(buffer, lang)
      end)
    end,
  })
end

return Plugin

