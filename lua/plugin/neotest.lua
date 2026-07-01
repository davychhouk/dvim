return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
		"nvim-neotest/neotest-python",
		"marilari88/neotest-vitest",
	},
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Test nearest",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Test file",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop test",
		},
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Watch file tests",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Test summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Test output",
		},
		{
			"<leader>tp",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Test output panel",
		},
	},
	config = function()
		-- All fields present to satisfy neotest.Config; empty tables deep-merge to defaults,
		-- scalars carry the upstream default value.
		require("neotest").setup({
			adapters = {
				require("neotest-golang"),
				require("neotest-python")({ dap = { justMyCode = false } }),
				require("neotest-vitest"),
				require("rustaceanvim.neotest"),
			},
			log_level = 3,
			default_strategy = "integrated",
			consumers = {},
			icons = {},
			highlights = {},
			floating = {},
			strategies = {},
			run = {},
			summary = {},
			output = {},
			output_panel = {},
			quickfix = {},
			status = {},
			state = {},
			watch = {},
			diagnostic = {},
			projects = {},
			discovery = {},
			running = {},
		})
	end,
}
