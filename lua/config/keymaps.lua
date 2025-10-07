local utils = require("config.utils")

-- ============================================================================
-- DELETE OPERATIONS
-- ============================================================================

-- Delete lines (Alt+d followed by d)
vim.keymap.set("n", "<A-d>d", '"_dd', { noremap = true, desc = "Delete current line in normal mode" })
vim.keymap.set("v", "<A-d>d", '"_d', { noremap = true, desc = "Delete current line in visual mode" })
vim.keymap.set("i", "<A-d>d", '"<Esc>_dd', { noremap = true, desc = "Delete current line in insert mode" })

-- Delete word (Alt+d followed by w)
vim.keymap.set("n", "<A-d>w", '"_diw', { desc = "Delete current word in normal mode" })
vim.keymap.set("v", "<A-d>w", '"_d"', { desc = "Delete selected word in visual mode" })
vim.keymap.set("i", "<A-d>w", '"<Esc>_diw', { desc = "Delete current word in insert mode" })

-- Delete all lines
vim.keymap.set("n", "<A-l>", '"_dG', { noremap = true, desc = "Delete all lines without affecting clipboard" })

-- ============================================================================
-- COPY/PASTE OPERATIONS
-- ============================================================================
vim.keymap.set("n", "<C-y>", '"+yy', { noremap = true, desc = "Copy entire line (normal mode)" })
vim.keymap.set("v", "<C-y>", '"+y', { noremap = true, desc = "Copy selection (visual mode)" })
vim.keymap.set("i", "<C-y>", '<Esc>"+yyi', { noremap = true, desc = "Copy entire line (insert mode)" })

-- ============================================================================
-- DUPLICATE LINES
-- ============================================================================
vim.keymap.set({ "n", "v" }, "<C-d><Down>", function()
  utils.duplicate_lines("down", false)
end, { desc = "Duplicate line/selection below (no gap)" })

vim.keymap.set({ "n", "v" }, "<C-d><Right>", function()
  utils.duplicate_lines("down", true)
end, { desc = "Duplicate line/selection below (with gap)" })

vim.keymap.set({ "n", "v" }, "<C-d><Up>", function()
  utils.duplicate_lines("up", false)
end, { desc = "Duplicate line/selection above (no gap)" })

vim.keymap.set({ "n", "v" }, "<C-d><Left>", function()
  utils.duplicate_lines("up", true)
end, { desc = "Duplicate line/selection above (with gap)" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================

-- Select all
vim.keymap.set("n", "<A-a>", "ggVG", { desc = "Select all" })

-- Save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", function()
  vim.cmd("silent! write")
  if vim.bo.modified then
    vim.notify("Failed to save", vim.log.levels.ERROR)
  else
    vim.notify("File saved", vim.log.levels.INFO)
  end
end, { desc = "Save file" })

-- ============================================================================
-- FORMATTING (Conform.nvim)
-- ============================================================================

-- Toggle auto format globally
vim.keymap.set("n", "<leader>ch", function()
  require("lazyvim.util").format.toggle()
end, { desc = "Toggle auto format (global)" })

-- Toggle auto format per buffer
vim.keymap.set("n", "<leader>ci", function()
  require("lazyvim.util").format.toggle(true)
end, { desc = "Toggle auto format (buffer)" })

-- Toggle ruff notifications
vim.keymap.set("n", "<leader>cz", "<cmd>RuffNotifyToggle<cr>", { desc = "Toggle Ruff notifications" })

-- ============================================================================
-- AI
-- ============================================================================

-- CodeCompanion mappings (Alt+c followed by action key)
vim.keymap.set("n", "<A-c>c", "<cmd>CodeCompanionChat<cr>", { noremap = true, desc = "Open CodeCompanion chat" })
vim.keymap.set(
  "v",
  "<A-c>c",
  "<cmd>CodeCompanionChat<cr>",
  { noremap = true, desc = "Open CodeCompanion chat with selection" }
)
vim.keymap.set("n", "<A-c>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, desc = "CodeCompanion actions" })
vim.keymap.set(
  "v",
  "<A-c>a",
  "<cmd>CodeCompanionActions<cr>",
  { noremap = true, desc = "CodeCompanion actions on selection" }
)
vim.keymap.set("n", "<A-c>t", "<cmd>CodeCompanionToggle<cr>", { noremap = true, desc = "Toggle CodeCompanion chat" })
vim.keymap.set("n", "<A-c>i", "<cmd>CodeCompanion<cr>", { noremap = true, desc = "CodeCompanion inline prompt" })
vim.keymap.set("v", "<A-c>i", "<cmd>CodeCompanion<cr>", { noremap = true, desc = "CodeCompanion inline on selection" })
