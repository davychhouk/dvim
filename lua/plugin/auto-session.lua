return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>wr", "<CMD>SessionRestore<CR>", desc = "Restore session for cwd" },
		{ "<leader>ws", "<CMD>SessionSave<CR>", desc = "Save session for auto session root dir" },
	},
	config = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		require("auto-session").setup({
			auto_restore = true,
			pre_save_cmds = {
				function()
					pcall(function()
						require("claudecode.terminal").close()
					end)
				end,
			},
			suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
		})
	end,
}
