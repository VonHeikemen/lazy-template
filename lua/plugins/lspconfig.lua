local Plugin = {'neovim/nvim-lspconfig'}
local user = {}

Plugin.dependencies =  {
  {'hrsh7th/cmp-nvim-lsp'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
}

Plugin.cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.init()
  if vim.fn.has('nvim-0.11') == 1 then
    user.compat_11()
  else
    user.compat_09()
  end
end

function Plugin.config()
  local lspconfig = require('lspconfig')
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

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
        lspconfig[server].setup({
          capabilities = lsp_capabilities,
        })
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
  vim.keymap.set({'i', 's'}, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

  -- These are custom keymaps
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
end

function user.compat_09()
  vim.diagnostic.config({
    virtual_text = true,
    float = {
      border = 'rounded',
    },
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )

  local function sign_define(args)
    vim.fn.sign_define(args.name, {
      texthl = args.name,
      text = args.text,
      numhl = ''
    })
  end

  sign_define({name = 'DiagnosticSignError', text = '✘'})
  sign_define({name = 'DiagnosticSignWarn', text = '▲'})
  sign_define({name = 'DiagnosticSignHint', text = '⚑'})
  sign_define({name = 'DiagnosticSignInfo', text = '»'})

  if vim.fn.has('nvim-0.10') == 0 then
    -- This were added to Neovim on version v0.10
    vim.keymap.set('n', '<C-w>d', '<cmd>lua vim.diagnostic.open_float()<cr>')
    vim.keymap.set('n', '<C-w><C-d>', '<cmd>lua vim.diagnostic.open_float()<cr>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
end

function user.compat_11()
  -- 'winborder' is a very recent addition to Neovim
  -- this will fail if your nightly version is not recent enough
  pcall(function() vim.o.winborder = 'rounded' end)

  vim.diagnostic.config({
    virtual_text = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '✘',
        [vim.diagnostic.severity.WARN] = '▲',
        [vim.diagnostic.severity.HINT] = '⚑',
        [vim.diagnostic.severity.INFO] = '»',
      },
    },
  })
end

return Plugin

