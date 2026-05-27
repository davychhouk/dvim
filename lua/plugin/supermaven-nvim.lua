return {
	"supermaven-inc/supermaven-nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<TAB>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			color = {
				suggestion_color = "#FFFFFF",
				cterm = 244,
			},
			log_level = "info",
			disable_inline_completion = false,
			disable_keymaps = false,
		})
	end,
}
