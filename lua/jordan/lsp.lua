-- check that lspconfig is installed and get it
local lspc_ok, lspc = pcall(require, 'lspconfig')
if not lspc_ok then
  print('failed to require lspconfig')
  return
end

-- check that cmp_nvim_lsp is installed
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
  print('failed to require cmp_nvim_lsp')
  return
end

-- update capabilities from cmp_nvim_lsp
-- pass this to language servers
local capabilities = cmp_nvim_lsp.default_capabilities()

-- configure diagnostics
vim.diagnostic.config {
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focasable = false,
    style = 'minimal',
    source = 'always',
    header = '',
    prefix = ''
  }
}

local function on_attach()
  -- setup keymaps for common lsp functionality
  -- setup vim omnifunc style completion for this buffer
  -- vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- buffer=0 only sets mapping in current buffer
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
  -- goto type definition
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.type_definition, {buffer=0})
  -- goto implentation
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
  -- goto next diagnostic
  vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { buffer = 0 })
  -- goto prev diagnostic
  vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { buffer = 0 })
  -- open floating diagnostics
  -- function to open_floating diagnostic with config
  local function open_diagnostic()
    vim.diagnostic.open_float {
      scope = 'cursor'
    }
  end

  vim.keymap.set('n', '<leader>do', open_diagnostic, { buffer = 0 })
  -- rename variables, works for scope across project
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = 0 })
  -- see code_actions vim.lsp.buf.code_action
  -- vim.cmd [[command Format :lua vim.lsp.buf.formatting()<cr>]]
end


-- configure lsps
-- lua

lspc.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {
        enable = false,
      }
    }
  }
}

-- python
lspc.pylsp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pylsp = {
      configurationSources = {'flake8'},
      plugins = {
	pycodestyle = {
	  enabled = false
	},
	mcabe = {
	  enabled = false
	},
	pyflakes = {
	  enabled = false
	},
	flake8 = {
	  enabled = true
	},
	black = {
	  enabled = false
	},
	autopep8 = {
	  enabled = false
	},
	yapf = {
	  enabled = true
	}

      }
    }
  }
}

-- latex
lspc.texlab.setup{
  filetypes = { 'tex', 'bib', }
}

-- dockerfile
lspc.dockerls.setup{
  capabilities=capabilities,
  on_attach=on_attach
}
