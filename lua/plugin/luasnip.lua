return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "v2.*",
	build = "make install_jsregexp",
	event = "VeryLazy",
	config = function()
		-- Required for friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()
		-- Load custom snippets
		require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
	end,
}
