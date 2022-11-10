-- set colorscheme
vim.g.enfocado_style = "nature"
vim.o.background = "dark"
vim.o.termguicolors = true
--vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
--require("catppuccin").setup {
--  term_colors = true,
--  background = false,
--  integrations = {
--    treesitter = true,
--    ts_rainbow = true,
--    native_lsp = {
--	enabled = true,
--	virtual_text = {
--		errors = { "italic" },
--		hints = { "italic" },
--		warnings = { "italic" },
--		information = { "italic" },
--	},
--	underlines = {
--		errors = { "underline" },
--		hints = { "underline" },
--		warnings = { "underline" },
--		information = { "underline" },
--	},
--        cmp = true,
--    },
--
--  }
--}
vim.cmd [[colorscheme enfocado]]
