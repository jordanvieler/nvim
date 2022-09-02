-- default options
local opts = { noremap = true, silent = true }
-- short hand for keymap
local keymap = vim.api.nvim_set_keymap

-- modes:
-- 	"n" = normal
-- 	"i" = insert
-- 	"v" = visual
-- 	"x" = visual block
-- 	"t" = term
-- 	"c" = command

-- window mappings
-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resizing windows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Netrw
keymap("n", "<leader>e", "<cmd>Explore <CR>", opts)

-- reload config
keymap("n", "<leader>sv", "<cmd>luafile $MYVIMRC<CR>", opts)
