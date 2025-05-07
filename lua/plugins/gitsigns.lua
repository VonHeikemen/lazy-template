local Plugin = {'lewis6991/gitsigns.nvim'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

if vim.fn.has('nvim-0.10') == 0 then
  -- Last version that supports Neovim v0.9
  Plugin.commit = 'ee28ba3e70ecea811b8f6d7b51d81976e94b121c'
  Plugin.pin = true
end

-- See :help gitsigns-usage
Plugin.opts = {
  signs = {
    add = {text = '▎'},
    change = {text = '▎'},
    delete = {text = '➤'},
    topdelete = {text = '➤'},
    changedelete = {text = '▎'},
  }
}

return Plugin

