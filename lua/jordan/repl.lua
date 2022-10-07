local function getCellLines(start_delim,  end_delim)
  -- gets the line numbers of the current or cell aboves deliminators
  -- get the current cursor position to jump back to later
  local saved_cursor_row, saved_cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  -- adding 1 back to the col because nvim_* decided to 0 index cols for this method
  local saved_cursor_pos = {saved_cursor_row, saved_cursor_col + 1}
  vim.fn.cursor({0, 9999})
  local start_line = vim.fn.search(start_delim, 'bW')
  local end_line = vim.fn.search(end_delim, 'Wn')
  vim.fn.cursor(saved_cursor_pos)
  return {start_line, end_line}
end

local function getCell(start_delim, end_delim)
  --[[
  Takes a start delimintator and end deliminator for a cell,
  and returns each line between the deliminators as a table of strings.
  returns an empty table if no cells were found.
  ]]--
  local start_line, end_line = unpack(getCellLines(start_delim, end_delim))
  if start_line == 0 or end_line == 0 then
   return {}
  end
  start_line = start_line + 1 --inc. to exclude cell header
  end_line = end_line -1 -- dec. to exclude cell footer
  return vim.fn.getline(start_line, end_line)

end

local function sendToTmux(data, panel_id)
  -- Takes a table data(lines) and tmux panel id, and sends the keys to tmux with necessary \r
  local num_lines = #data
  print(vim.inspect(data))
  if num_lines == 0 then
    return 1
  elseif num_lines == 1 then
    local line = data[1]
    os.execute('tmux send-keys -t '..panel_id..' "'..line..'" Enter')
    return 0

  elseif num_lines > 1 then
    -- send C-o to ipython to specify multiline
    os.execute('tmux send-keys -t '..panel_id..' C-o')
    for _, line in pairs(data) do
      os.execute('tmux send-keys -t '..panel_id..' "'..line..'" Enter')
    end
    os.execute('tmux send-keys -t 1 Enter')
    return 0
  end
end

function MakeCellFunctions(start_delim, end_delim)
  --takes start_delim and end_delim and returns cell functions with start_delim and end_delim bound
  local function sendCellToTmux()
    --[[
    Gets a cell under the cursor and then sends cell contents, line by line to a tmux pane.
    ]]--
    --TODO: prompt user for -t value when first called in session
    local cell = getCell(start_delim, end_delim)
    if sendToTmux(cell, 1) == 1 then
      print('No lines were received to send.')
      return 1
    end
  end

  local function makeCell()
    local start_line, end_line = unpack(getCellLines(start_delim, end_delim))
    local cell_frame = {'', start_delim, '', end_delim, ''}
    if start_line > 0 and end_line > 0 then
      vim.fn.append(end_line, cell_frame)
      vim.fn.cursor({end_line+3, 1})
    else
      local current_line = vim.fn.line('.')
      vim.fn.append(current_line, cell_frame)
      vim.fn.cursor({current_line+3, 1})
    end
    return 0
  end

  local function sendAndMakeCell()
    -- do not make a new cell if there was no cell to send
    if sendCellToTmux() == 1 then
      print('No cells were found to execute.')
      return 1
    end
    makeCell()
    return 0
  end
  local cell_functions = {}
  cell_functions['sendCellToTmux'] = sendCellToTmux
  cell_functions['makeCell'] = makeCell
  cell_functions['sendAndMakeCell'] = sendAndMakeCell

  return cell_functions
end

function SendVisualSelection()
  -- yank to visual selection into 9 register,
  vim.fn.feedkeys('"9y', 'x')
  -- send the register to tmux
  local yanked_contents = vim.fn.getreg('9')
  local lines = vim.fn.split(yanked_contents, '\n')
  sendToTmux(lines, 1)
end
