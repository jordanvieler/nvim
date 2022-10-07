-- cell start deliminator
local cell_start_delim='#----+----#'
-- cell end deliminator
local cell_end_delim='#--_____--#'

local cell_functions = MakeCellFunctions(cell_start_delim, cell_end_delim)
vim.keymap.set('n', '<leader>r', cell_functions['sendCellToTmux'], { buffer=0 })
vim.keymap.set('n', '<leader>c', cell_functions['makeCell'], { buffer=0 })
vim.keymap.set('n', '<leader>s', cell_functions['sendAndMakeCell'], { buffer=0 })
vim.keymap.set('v', '<leader>v', SendVisualSelection, { buffer=0 })
