local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
  return
end

local status_ok, cmp_neurogenesis = pcall(require, 'cmp_neurogenesis')
if not status_ok then
  vim.notify('Could not load module cmp_neurogenesis')
  return
end

-- check nil for cmp. Thanks LSP!
if not cmp then
  print('cmp returned nil')
  return
end

cmp_neurogenesis.setup({trigger_char='@', brain_path='/home/jordan/brain'})

cmp.setup {
  --completion = {
  --  autocomplete = false
  --},
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    }),
  }),
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    -- { name = 'path' },
    { name = 'luasnip' },
    -- { name = 'buffer', keyword_length = 5 }
    { name = 'neurogenesis'}
  },
}

-- map cmp to omnifunc completion
vim.keymap.set('i', '<C-x><C-o>', cmp.complete)
