-- cell start deliminator
local cell_start_delim='#----+----#'
-- cell end deliminator
local cell_end_delim='#--_____--#'

local repl_functions = MakeREPLFunctions(cell_start_delim, cell_end_delim)
vim.keymap.set('n', '<leader>r', repl_functions['sendCellToTmux'], { buffer=0 })
vim.keymap.set('n', '<leader>c', repl_functions['makeCell'], { buffer=0 })
vim.keymap.set('n', '<leader>s', repl_functions['sendAndMakeCell'], { buffer=0 })
vim.keymap.set('v', '<leader>v', repl_functions['sendVisualSelection'], { buffer=0 })
