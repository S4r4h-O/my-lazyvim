-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Undo/Redo
vim.keymap.set("n", "<A-u>", "u", { desc = "Undo changes" })

-- Delete lines (Alt+d followed by d)
vim.keymap.set("n", "<A-d>d", '"_dd', { noremap = true, desc = "Delete current line in normal mode" })
vim.keymap.set("v", "<A-d>d", '"_d', { noremap = true, desc = "Delete current line in visual mode" })
vim.keymap.set("i", "<A-d>d", '"<Esc>_dd', { noremap = true, desc = "Delete current line in insert mode" })

-- Delete word (Alt+d followed by w)
vim.keymap.set("n", "<A-d>w", '"_diw', { desc = "Delete current word in normal mode" })
vim.keymap.set("v", "<A-d>w", '"_d"', { desc = "Delete selected word in visual mode" })
vim.keymap.set("i", "<A-d>w", '"<Esc>_diw', { desc = "Delete current word in insert mode" })

-- Copy / Paste
vim.keymap.set("v", "<C-S-c>", '"+y', { noremap = true, desc = "Copy selection to clipboard in visual mode" })
vim.keymap.set("n", "<C-y>", '"+yy', { noremap = true, desc = "Copy entire line (normal mode)" })
vim.keymap.set("v", "<C-y>", '"+y', { noremap = true, desc = "Copy selection (visual mode)" })
vim.keymap.set("i", "<C-y>", '<Esc>"+yyi', { noremap = true, desc = "Copy entire line (insert mode)" })

local function duplicate_lines(direction, gap)
  local mode = vim.api.nvim_get_mode().mode
  local start_line, end_line
  local line_count = vim.api.nvim_buf_line_count(0)

  -- Obter range de linhas selecionadas (visual) ou linha atual (normal)
  if mode:match("[vV]") then
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  local num_lines = end_line - start_line + 1
  local new_lines = {}

  -- Coletar linhas para duplicação
  for i = start_line, end_line do
    table.insert(new_lines, vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1])
  end

  -- Determinar posição de inserção baseada na direção e gap
  local insert_pos
  if direction == "down" then
    insert_pos = end_line + (gap and 1 or 0)
  else -- up
    insert_pos = start_line - (gap and 2 or 1)
  end

  -- Ajustar para limites do buffer
  insert_pos = math.max(math.min(insert_pos, line_count), 0)

  -- Inserir linhas duplicadas
  vim.api.nvim_buf_set_lines(0, insert_pos, insert_pos, false, new_lines)

  -- Adicionar linha em branco se necessário
  if gap then
    local gap_pos = direction == "down" and insert_pos + num_lines or insert_pos + 1
    vim.api.nvim_buf_set_lines(0, gap_pos, gap_pos, false, { "" })
  end

  -- Posicionar cursor
  if mode:match("[vV]") then
    local new_cursor_line = direction == "down" and insert_pos + 1 or insert_pos + num_lines
    vim.api.nvim_win_set_cursor(0, { new_cursor_line, 0 })
    vim.cmd("normal! V") -- Re-selecionar o bloco duplicado
  else
    local new_cursor_line = direction == "down" and start_line or start_line + num_lines + (gap and 1 or 0)
    vim.api.nvim_win_set_cursor(0, { new_cursor_line, 0 })
  end
end

-- Mapeamentos
vim.keymap.set({ "n", "v" }, "<C-d><Down>", function()
  duplicate_lines("down", false)
end, { desc = "Duplicar linha/seleção abaixo (sem gap)" })

vim.keymap.set({ "n", "v" }, "<C-d><Right>", function()
  duplicate_lines("down", true)
end, { desc = "Duplicar linha/seleção abaixo (com gap)" })

vim.keymap.set({ "n", "v" }, "<C-d><Up>", function()
  duplicate_lines("up", false)
end, { desc = "Duplicar linha/seleção acima (sem gap)" })

vim.keymap.set({ "n", "v" }, "<C-d><Left>", function()
  duplicate_lines("up", true)
end, { desc = "Duplicar linha/seleção acima (com gap)" })

-- File operations
vim.keymap.set("n", "<A-a>", "ggVG", { desc = "Select all" })
vim.keymap.set("n", "<A-l>", '"_dG', { noremap = true, desc = "Delete all lines without affecting clipboard" })

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", function()
  vim.cmd("silent! write")
  if vim.bo.modified then
    vim.notify("Failed to save", vim.log.levels.ERROR)
  else
    vim.notify("File saved", vim.log.levels.INFO)
  end
end, { desc = "Save File" })

-- Conform.nvim formatting
-- Desabilitar globalmente
vim.keymap.set("n", "<leader>uf", function()
  require("lazyvim.util").format.toggle()
end, { desc = "Toggle auto format (global)" })

-- Desabilitar por buffer
vim.keymap.set("n", "<leader>uF", function()
  require("lazyvim.util").format.toggle(true)
end, { desc = "Toggle auto format (buffer)" })

-- Formatação manual (sempre funciona)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("lazyvim.util").format({ force = true })
end, { desc = "Format" })
