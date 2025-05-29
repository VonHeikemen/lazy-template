local Plugin = {'nvim-treesitter/nvim-treesitter-textobjects'}

Plugin.branch = 'main'
Plugin.lazy = false

function Plugin.config()
  local ts_select_mod = require('nvim-treesitter-textobjects.select')

  local keymap = function(lhs, ts_capture)
    vim.keymap.set({'x', 'o'}, lhs, function()
      ts_select_mod.select_textobject(ts_capture, 'textobjects')
    end)
  end

  keymap('af', '@function.outer')
  keymap('if', '@function.inner')
  keymap('ac', '@class.outer')
  keymap('ic', '@class.inner')
end

return Plugin

