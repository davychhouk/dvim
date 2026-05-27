return {
	enabled = true,
	win = { width = 0.96 },
	zoom = {
		toggles = {},
		center = false,
		show = { statusline = true, tabline = true },
		win = { backdrop = false, width = 0 },
		on_close = function()
			if vim.g._zoom_had_explorer then
				vim.g._zoom_had_explorer = false
				Snacks.explorer(require("config.snacks-explorer"))
			end
		end,
	},
}
