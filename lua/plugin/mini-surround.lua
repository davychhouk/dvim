return {
	"nvim-mini/mini.surround",
	version = false,
	event = "BufReadPost",
	config = function()
		require("mini.surround").setup({
			search_method = "cover_or_next",
			mappings = {
				add = "gsa",
				delete = "gsd",
				replace = "gsr",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				update_n_lines = "gsn",
				suffix_last = "l",
				suffix_next = "n",
			},
		})
		-- Register descriptions for which-key without overriding the keymaps
		require("which-key").add({
			{ "gsa", desc = "Add surrounding" },
			{ "gsd", desc = "Delete surrounding" },
			{ "gsr", desc = "Replace surrounding" },
			{ "gsf", desc = "Find surrounding (right)" },
			{ "gsF", desc = "Find surrounding (left)" },
			{ "gsh", desc = "Highlight surrounding" },
			{ "gsn", desc = "Update surrounding n lines" },
		})
	end,
}
