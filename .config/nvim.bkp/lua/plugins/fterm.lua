return {
  "numToStr/FTerm.nvim",
  config = function()
    local fterm = require("FTerm")

    -- Configuração explícita (se necessária)
    fterm.setup({
      border = "double",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    })

    -- Toggle com Alt+t no modo normal
    vim.keymap.set("n", "<A-t>", fterm.toggle, { desc = "Toggle FTerm (normal)" })

    -- Toggle com Alt+t no modo terminal
    vim.keymap.set("t", "<A-t>", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
      fterm.toggle()
    end, { desc = "Toggle FTerm (terminal)" })

    -- Comando para encerrar sessão
    vim.api.nvim_create_user_command("FTermExit", function()
      fterm.exit()
    end, { bang = true, desc = "Exit FTerm" })
  end,
}
