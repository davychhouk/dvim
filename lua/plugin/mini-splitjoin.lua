return {
	"nvim-mini/mini.splitjoin",
	version = false,
	event = "VeryLazy",
	config = function()
		-- Default key: gS
		require("mini.splitjoin").setup()
	end,
}
