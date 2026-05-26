return {
	"nvim-mini/mini.trailspace",
	version = false,
	event = "BufReadPost",
	config = function()
		require("mini.trailspace").setup()
		vim.keymap.set("n", "<leader>cw", function()
			require("mini.trailspace").trim()
		end, { desc = "Trim trailing whitespace" })
		vim.keymap.set("n", "<leader>cW", function()
			require("mini.trailspace").trim_last_lines()
		end, { desc = "Trim trailing blank lines" })
	end,
}
