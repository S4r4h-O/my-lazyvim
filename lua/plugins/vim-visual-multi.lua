return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    -- Disable default mappings to avoid conflicts
    vim.g.VM_default_mappings = 0

    -- Set custom leader (default is \\)
    vim.g.VM_leader = "\\"

    -- Custom mappings
    vim.g.VM_maps = {
      -- Find/select words
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",

      -- Add cursors vertically
      ["Add Cursor Down"] = "<C-Down>",
      ["Add Cursor Up"] = "<C-Up>",

      -- Select with arrows
      ["Select l"] = "<S-Right>",
      ["Select h"] = "<S-Left>",
      ["Select Cursor Down"] = "<M-C-Down>",
      ["Select Cursor Up"] = "<M-C-Up>",

      -- Navigation
      ["Find Next"] = "]",
      ["Find Prev"] = "[",
      ["Goto Next"] = "}",
      ["Goto Prev"] = "{",

      -- Skip/remove regions
      ["Skip Region"] = "q",
      ["Remove Region"] = "Q",

      -- Mode switching
      ["Switch Mode"] = "<Tab>",

      -- Start VM
      ["Select All"] = "\\A",
      ["Start Regex Search"] = "\\/",
      ["Add Cursor At Pos"] = "\\\\",
      ["Select Operator"] = "gs",

      -- Visual mode
      ["Visual Regex"] = "\\/",
      ["Visual All"] = "\\A",
      ["Visual Add"] = "\\a",
      ["Visual Find"] = "\\f",
      ["Visual Cursors"] = "\\c",
    }

    -- Highlight colors
    vim.g.VM_highlight_matches = "underline"
  end,
}
