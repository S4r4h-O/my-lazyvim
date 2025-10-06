local utils = require("config.utils")

vim.api.nvim_create_user_command("RuffNotifyToggle", utils.toggle_ruff_notify, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = utils.run_ruff_on_save,
})

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
