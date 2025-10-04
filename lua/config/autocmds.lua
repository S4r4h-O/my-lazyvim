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
