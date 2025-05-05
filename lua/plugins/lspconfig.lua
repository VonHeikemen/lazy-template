local Plugin = {'neovim/nvim-lspconfig'}
local user = {}

Plugin.dependencies =  {
  {'hrsh7th/cmp-nvim-lsp'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
}

Plugin.cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

if vim.fn.has('nvim-0.10') == 0 then
  -- Last version that supports Neovim v0.9
  Plugin.tag = 'v1.8.0'
  Plugin.pin = true
end

function Plugin.config()
  if vim.fn.has('nvim-0.11') == 0 then
    user.compat_09()
    user.legacy_api = true
  end

  user.lsp_capabilities()

  local lspconfig = require('lspconfig')
  local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

  local setup = function(server, opts)
    if user.legacy_api or user.legacy_config(server) then
      lspconfig[server].setup(opts or {})
      return
    end

    if opts then
      vim.lsp.config(server, opts)
    end

    vim.lsp.enable(server)
  end

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
        setup(server, nil)
      end,
      ['lua_ls'] = function()
        -- if you install the language server for lua it will
        -- load the config from lua/plugins/lsp/lua_ls.lua
        local lua_opts = require('plugins.lsp.lua_ls')
        setup('lua_ls', lua_opts)
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

  -- note: border style is only effective in neovim v0.11
  -- below that version the style is configured by the handlers, see user.compat_09()
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<cr>', opts)
  vim.keymap.set({'i', 's'}, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help({border = "rounded"})<cr>', opts)
end

function user.compat_09()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )
end

function user.lsp_capabilities()
  local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lc_defaults = require('lspconfig').util.default_config

  lc_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lc_defaults.capabilities,
    cmp_capabilities
  )

  if vim.lsp.config then
    vim.lsp.config('*', {capabilities = cmp_capabilities})
  end
end

function user.legacy_config(server)
  local configs = require('plugins.lsp.legacy_configs')
  return vim.tbl_contains(configs, server)
end

return Plugin

