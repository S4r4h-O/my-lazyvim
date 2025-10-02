-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================

local M = {}

-- Duplicate lines function
-- @param direction string: "up" or "down"
-- @param gap boolean: add empty line between original and duplicate
M.duplicate_lines = function(direction, gap)
  local mode = vim.api.nvim_get_mode().mode
  local is_visual = mode:match("[vV]") ~= nil

  local start_line, end_line
  if is_visual then
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local num_lines = #lines

  local insert_line, cursor_line

  if direction == "down" then
    insert_line = end_line
    if gap then
      table.insert(lines, 1, "")
    end
    vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, lines)
    cursor_line = insert_line + (gap and 2 or 1)
  else
    insert_line = start_line - 1
    if gap then
      table.insert(lines, "")
    end
    vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, lines)
    cursor_line = start_line
  end

  vim.api.nvim_win_set_cursor(0, { cursor_line, 0 })

  if is_visual then
    vim.cmd("normal! " .. num_lines - 1 .. "j")
    vim.cmd("normal! V" .. (num_lines - 1 == 0 and "" or (num_lines - 1) .. "k"))
  end
end

return M
