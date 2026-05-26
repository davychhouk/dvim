return {
	"nvim-mini/mini.align",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.align").setup()
		require("which-key").add({
			{ "ga", desc = "Align", mode = { "n", "x" } },
			{ "gA", desc = "Align with preview", mode = { "n", "x" } },
		})
	end,
}
