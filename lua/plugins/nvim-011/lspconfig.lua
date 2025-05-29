local Plugin = {'neovim/nvim-lspconfig'}
local user = {}

Plugin.dependencies =  {
  {'hrsh7th/cmp-nvim-lsp'},
  {'mason-org/mason.nvim'},
  {'mason-org/mason-lspconfig.nvim'},
}

Plugin.cmd = {'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.config()
  local lspconfig = require('lspconfig')
  local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

  user.lsp_capabilities()

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = user.on_attach
  })

  local setup = function(server, opts)
    if user.legacy_config(server) then
      lspconfig[server].setup(opts or {})
      return
    end

    if opts then
      vim.lsp.config(server, opts)
    end

    vim.lsp.enable(server)
  end

  local installed_servers = require('mason-lspconfig').get_installed_servers
  for _, server in ipairs(installed_servers()) do
    local opts = nil

    if server == 'lua_ls' then
      -- if you install the language server for lua it will
      -- load the config from lua/plugins/lsp/lua_ls.lua
      opts = require('plugins.lsp.lua_ls')
    end

    setup(server, opts)
  end
end

function user.on_attach(event)
  local opts = {buffer = event.buf}

  -- You can search each function in the help page.
  -- For example :help vim.lsp.buf.hover()

  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<cr>', opts)
  vim.keymap.set({'i', 's'}, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help({border = "rounded"})<cr>', opts)
end

function user.lsp_capabilities()
  local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lsp_defaults = require('lspconfig').util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    cmp_capabilities
  )

  vim.lsp.config('*', {capabilities = cmp_capabilities})
end

function user.legacy_config(server)
  local configs = require('plugins.lsp.legacy_configs')
  return vim.tbl_contains(configs, server)
end

return Plugin

