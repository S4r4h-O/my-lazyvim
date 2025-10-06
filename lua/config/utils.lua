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

-- Ruff notification state file
M.ruff_notify_file = vim.fn.stdpath("data") .. "/ruff_notify_enabled"

-- Check if ruff notifications are enabled
M.is_ruff_notify_enabled = function()
  return vim.fn.filereadable(M.ruff_notify_file) == 1
end

-- Toggle ruff notifications
M.toggle_ruff_notify = function()
  if M.is_ruff_notify_enabled() then
    vim.fn.delete(M.ruff_notify_file)
    vim.notify("Ruff notifications disabled", vim.log.levels.INFO)
  else
    vim.fn.writefile({}, M.ruff_notify_file)
    vim.notify("Ruff notifications enabled", vim.log.levels.INFO)
  end
end

-- Run ruff on save
M.run_ruff_on_save = function()
  if vim.fn.executable("ruff") == 0 then
    if M.is_ruff_notify_enabled() then
      vim.notify("ruff not found in PATH", vim.log.levels.ERROR)
    end
    return
  end

  local filepath = vim.fn.expand("%:p")
  local check_result = vim.fn.system("ruff check --fix " .. vim.fn.shellescape(filepath))

  if vim.v.shell_error ~= 0 and M.is_ruff_notify_enabled() then
    vim.notify("Ruff check errors:\n" .. check_result, vim.log.levels.WARN)
  end

  local format_result = vim.fn.system("ruff format " .. vim.fn.shellescape(filepath))

  if vim.v.shell_error ~= 0 and M.is_ruff_notify_enabled() then
    vim.notify("Ruff format errors:\n" .. format_result, vim.log.levels.ERROR)
  end

  vim.cmd("checktime")
end

return M
