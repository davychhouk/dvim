return {
	enabled = true,
	layout = { layout = { backdrop = false } },
	sources = {
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
