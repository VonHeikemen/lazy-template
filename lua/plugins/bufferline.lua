local Plugin = {'akinsho/bufferline.nvim'}

Plugin.opts = {
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'snacks_layout_box'},
    },
  },
  -- :help bufferline-highlights
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      fg = {attribute = 'fg', highlight = 'Function'},
      italic = false
    }
  }
}

function Plugin.init()
  vim.keymap.set('n', 'sb', '<cmd>BufferLinePick<cr>', {desc = 'Pick a visible tab'})
end

return Plugin

