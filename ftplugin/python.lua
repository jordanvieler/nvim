-- cell start deliminator
local cell_start_delim='#----+----#'
-- cell end deliminator
local cell_end_delim='#--_____--#'

local status_ok, cyto = pcall(require, 'cyto')
if not status_ok then
  return
end

local cyto_funcs = cyto.setup(cell_start_delim, cell_end_delim)

vim.keymap.set('n', '<leader>c', cyto_funcs.makeCell, { buffer=0 })
vim.keymap.set('n', '<Enter>', cyto_funcs.sendCellToTmux, { buffer=0 })
vim.keymap.set('n', '<A-Enter>', cyto_funcs.sendAndMakeCell, { buffer=0 })
vim.keymap.set('v', '<Enter>', cyto_funcs.sendVisualSelection, { buffer=0 })
