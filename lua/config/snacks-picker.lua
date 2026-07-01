return {
  enabled = true,
  layout = { layout = { backdrop = false } },
  sources = {
    notifications = {
      layout = {
        layout = {
          box = "horizontal",
          width = 0.8,
          min_width = 120,
          height = 0.8,
          {
            box = "vertical",
            border = true,
            title = "{title} {live} {flags}",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
          },
          { win = "preview", title = "{preview}", border = true, width = 0.65 },
        },
      },
      win = {
        input = { keys = { ["<c-y>"] = { "copy", mode = { "i", "n" } } } },
        list = { keys = { ["<c-y>"] = "copy" } },
      },
    },
    explorer = {
      -- H toggle hidden
      -- I toggle ignored
      auto_close = false,
      exclude = { ".git", "*.DS_Store" },
      win = {
        input = { keys = { ["<ESC>"] = { "", mode = "n" } } },
        list = {
					-- stylua: ignore
					keys = {
						["<ESC>"] = { "", mode = "n" },
						["<C-t>"] = { function() Snacks.terminal.toggle() end, mode = { "n" }, desc = "Toggle Terminal" },
					},
          -- stylua: ignore end
        },
      },
    },
  },
  ui_select = true,
}
