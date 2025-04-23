-- Note: mini.nvim is a collection of lua modules.
-- each module is basically a standalone plugin.
-- you can read their documentation on github:
-- https://github.com/echasnovski/mini.nvim

local Plugin = {'echasnovski/mini.nvim'}
local user = {}

Plugin.lazy = false

Plugin.dependencies = {
  {'rafamadriz/friendly-snippets'},
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    },
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  }
}

function Plugin.init()
  -- Enable "global" statusline
  vim.o.laststatus = 3

  -- Don't show current mode below statusline
  -- mini.statusline will handle this
  vim.o.showmode = false
end

function Plugin.config()
  -- See :help MiniSurround.config
  require('mini.surround').setup({})

  -- See :help MiniAi-textobject-builtin
  require('mini.ai').setup({n_lines = 500})

  -- See :help MiniIcons.config
  -- Change style to 'ascii' if you want to disable the fancy icons
  require('mini.icons').setup({style = 'glyph'})

  -- See :help MiniStatusline.config
  require('mini.statusline').setup({
    content = {active = user.statusline}
  })

  -- See :help MiniComment.config
  require('mini.comment').setup({
    options = {
      custom_commentstring = function()
        local cs = require('ts_context_commentstring').calculate_commentstring()
        return cs or vim.bo.commentstring
      end,
    },
  })

  -- See :help MiniNotify.config
  require('mini.notify').setup({
    lsp_progress = {
      enable = false,
    },
  })

  vim.notify = require('mini.notify').make_notify()

  -- See :help MiniSnippets.config
  local mini_snippets = require('mini.snippets')
  mini_snippets.setup({
    snippets = {
      mini_snippets.gen_loader.from_lang()
    }
  })

  -- See :help MiniJump2d.config
  require('mini.jump2d').setup({
    allowed_lines = {
      blank = false,
      fold = false,
    },
    allowed_windows = {
      not_current = false,
    },
    mappings = {
      start_jumping = '',
    },
  })

  -- Begin a 2 character jump using mini.jump2d
  vim.keymap.set({'n', 'x', 'o'}, 'gw', user.jump_char(), {})
end

-- See :help MiniStatusline-example-content
function user.statusline()
  local mini = require('mini.statusline')
  local mode, mode_hl = mini.section_mode({trunc_width = 120})
  local diagnostics = mini.section_diagnostics({trunc_width = 75})
  local lsp = mini.section_lsp({icon = 'LSP', trunc_width = 75})
  local filename = mini.section_filename({trunc_width = 140})
  local percent = '%2p%%'
  local location = '%3l:%-2c'

  return mini.combine_groups({
    {hl = mode_hl,                  strings = {mode}},
    {hl = 'MiniStatuslineDevinfo',  strings = {diagnostics, lsp}},
    '%<', -- Mark general truncate point
    {hl = 'MiniStatuslineFilename', strings = {filename}},
    '%=', -- End left alignment
    {hl = 'MiniStatuslineFilename', strings = {'%{&filetype}'}},
    {hl = 'MiniStatuslineFileinfo', strings = {percent}},
    {hl = mode_hl,                  strings = {location}},
  })
end

function user.jump_char()
  local opts = {hooks = {}}
  local noop = function() return {} end
  local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)

  opts.hooks.before_start = function()
    local prompt = {{'Chars: '}}
    local input = ''
    local total = 2

    vim.api.nvim_echo(prompt, false, {})

    for _=1, total, 1 do
      local ok, ch = pcall(vim.fn.getcharstr)
      if ok == false or ch == nil or ch == esc then
        opts.spotter = noop
        return
      end

      table.insert(prompt, {ch})
      vim.api.nvim_echo(prompt, false, {})

      if ch:match('[a-zA-Z]') then
        input = string.format('%s[%s%s]', input, ch:lower(), ch:upper())
      else
        input = string.format('%s%s', input, vim.pesc(ch))
      end
    end

    opts.spotter = require('mini.jump2d').gen_pattern_spotter(input)
  end

  return function()
    require('mini.jump2d').start(opts)
  end
end

return Plugin

