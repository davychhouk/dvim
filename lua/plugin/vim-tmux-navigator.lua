return {
	"christoomey/vim-tmux-navigator",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("t", "<C-h>", "<C-\\><C-n>:TmuxNavigateLeft<cr>", { desc = "Tmux Navigate Left" })
	end,
}
