return {
  "davychhouk/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-highlight-colors").setup({
      render = "virtual",
      virtual_symbol = require("util.icons").highlight.PREFIX,
      enable_ansi = true,
      enable_hex = true,
      enable_hsl = true,
      enable_hsl_without_function = true,
      enable_hyprland = true,
      enable_ls_colors = true,
      enable_named_colors = true,
      enable_oklch = true,
      enable_rgb = true,
      enable_short_hex = true,
      enable_tailwind = true,
      enable_var_usage = true,
      enable_xterm256 = true,
      enable_xtermTrueColor = true,
    })
  end,
}
