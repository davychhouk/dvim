return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = "BufReadPost",
	config = function()
		-- UFO Config
		local o = vim.o
		o.foldenable = true
		-- Hide foldcolumn for now since it looks so weird sometime
		-- Enable? Try this: o.foldcolumn = "auto:9"
		o.foldcolumn = "0"
		o.foldlevel = 99
		o.foldlevelstart = 99
		o.fillchars = "eob: ,fold: ,foldopen:,foldsep:│,foldclose:"
		require("ufo").setup({
			provider_selector = function()
				return { "lsp", "indent" }
			end,
		})
		-- Link FoldColumn to LineNr so it follows the theme
		vim.api.nvim_set_hl(0, "FoldColumn", { link = "LineNr" })
	end,
	keys = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			mode = "n",
			desc = "Open all folds",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			mode = "n",
			desc = "Close all folds",
		},
		{
			"zK",
			function()
				local win_id = require("ufo").peekFoldedLinesUnderCursor()
				if not win_id then
					vim.lsp.buf.hover()
				end
			end,
			mode = "n",
			desc = "Peek folded lines",
		},
	},
}
