local Plugin = {'neovim/nvim-lspconfig'}
local user = {}

Plugin.dependencies =  {
  {'hrsh7th/cmp-nvim-lsp'},
  {'mason-org/mason.nvim'},
  {'mason-org/mason-lspconfig.nvim'},
}

Plugin.cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

-- Last version that supports Neovim v0.9
Plugin.tag = 'v1.8.0'
Plugin.pin = true

function Plugin.init()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )
end

function Plugin.config()
  local lspconfig = require('lspconfig')
  local lsp_defaults = lspconfig.util.default_config
  local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    cmp_capabilities
  )

  local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = user.on_attach
  })

  -- See :help mason-lspconfig-settings
  require('mason-lspconfig').setup({
    handlers = {
      -- See :help mason-lspconfig-dynamic-server-setup
      function(server)
        -- See :help lspconfig-setup
        lspconfig[server].setup({})
      end,
      ['lua_ls'] = function()
        -- if you install the language server for lua it will
        -- load the config from lua/plugins/lsp/lua_ls.lua
        require('plugins.lsp.lua_ls')
      end
    }
  })
end

function user.on_attach(event)
  local opts = {buffer = event.buf}

  -- You can search each function in the help page.
  -- For example :help vim.lsp.buf.hover()

  -- These keymaps will become defaults after Neovim v0.11
  -- I've added them here for backwards compatibility
  vim.keymap.set('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)

  -- These are custom keymaps
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set({'i', 's'}, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
end

return Plugin

