return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPre",
  opts = {
    -- Render style
    render = "background",

    -- Virtual symbol configuration
    virtual_symbol = "■",
    virtual_symbol_prefix = "",
    virtual_symbol_suffix = " ",
    virtual_symbol_position = "inline",

    -- Enable/disable specific color formats
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_ansi = true,
    enable_hsl_without_function = true,
    enable_var_usage = true,
    enable_named_colors = true,
    enable_tailwind = true,

    -- Custom colors
    custom_colors = {},

    -- Exclusions
    exclude_filetypes = {},
    exclude_buftypes = {},
  },
  config = function(_, opts)
    vim.opt.termguicolors = true
    require("nvim-highlight-colors").setup(opts)
  end,
}
