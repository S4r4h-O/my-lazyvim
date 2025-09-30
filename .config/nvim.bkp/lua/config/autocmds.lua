-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Definir filetype htmldjango apenas para HTML em pastas de templates Django
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/templates/*.html",
    "*/templates/*/*.html",
    "*/templates/*/*/*.html",
  },
  callback = function()
    vim.bo.filetype = "htmldjango"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.rs",
  callback = function()
    vim.bo.filetype = "rust"
    vim.cmd("doautocmd FileType rust")
  end,
})
