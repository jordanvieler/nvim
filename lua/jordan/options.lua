-- defines global options

local options = {
  number = true,
  relativenumber = true,
  cursorline = true,
  splitbelow = true,
  splitright = true,
  mouse = "a",
  scrolloff = 4,
  sidescrolloff = 4,
  expandtab = true,
  shiftwidth = 4,
  laststatus = 3,
  showmode = false,
  termguicolors = true,
  numberwidth = 4,
  signcolumn = 'yes',
  completeopt = { 'menuone', 'noinsert', 'noselect' }

}

for option, value in pairs(options) do
  vim.opt[option] = value
end

vim.cmd [[highlight WinSeparator guibg=None]]

-- netrw configuration
vim.cmd [[let g:netrw_banner = 0]]
vim.cmd [[let g:netrw_liststyle = 3]]
vim.cmd [[let g:netrw_browse_split = 0]]
vim.cmd [[let g:netrw_altv = 1]]
vim.cmd [[let g:netrw_winsize = 20]]
