local Plugin = {'hrsh7th/nvim-cmp'}

Plugin.dependencies = {
  -- Completion sources
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'abeldekat/cmp-mini-snippets'},
  {'hrsh7th/cmp-path'},

 -- We'll be using mini.snippets
 {'nvim-mini/mini.nvim'},
}

if vim.fn.has('nvim-0.11') == 0 then
  vim.list_extend(Plugin.dependencies, {
    {
      'hrsh7th/cmp-nvim-lsp',
      pin = true,
      commit = 'a8912b88ce488f411177fc8aed358b04dc246d7b'
    },
  })
end

Plugin.event = 'InsertEnter'

function Plugin.config()
  local cmp = require('cmp')
  local select_opts = {behavior = cmp.SelectBehavior.Select}

  -- See :help cmp-config
  cmp.setup({
    snippet = {
      expand = function(args)
        require('mini.snippets').default_insert({body = args.body})
        cmp.resubscribe({'TextChangedI', 'TextChangedP'})
        require('cmp.config').set_onetime({sources = {}})
      end
    },
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp'},
      {name = 'buffer', keyword_length = 3},
      {name = 'mini_snippets', keyword_length = 2},
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    -- See :help cmp-mapping
    mapping = {
      ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<Down>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
      ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),

      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({select = true}),
      ['<CR>'] = cmp.mapping.confirm({select = false}),

      ['<S-Tab>'] = cmp.mapping.select_prev_item(select_opts),

      ['<Tab>'] = cmp.mapping(function(fallback)
        local col = vim.fn.col('.') - 1

        if cmp.visible() then
          cmp.select_next_item(select_opts)
        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
          fallback()
        else
          cmp.complete()
        end
      end, {'i', 's'}),

    },
  })
end

return Plugin

