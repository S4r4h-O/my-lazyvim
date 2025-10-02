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
vim.keymap.set("v", "<C-S-c>", '"+y', { noremap = true, desc = "Copy selection to clipboard in visual mode" })
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
vim.keymap.set("n", "<leader>uf", function()
  require("lazyvim.util").format.toggle()
end, { desc = "Toggle auto format (global)" })

-- Toggle auto format per buffer
vim.keymap.set("n", "<leader>uF", function()
  require("lazyvim.util").format.toggle(true)
end, { desc = "Toggle auto format (buffer)" })

-- Manual formatting (always works)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("lazyvim.util").format({ force = true })
end, { desc = "Format" })
