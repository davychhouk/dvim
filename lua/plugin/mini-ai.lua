return {
	"nvim-mini/mini.ai",
	version = false,
	event = "BufReadPost",
	config = function()
		local ai = require("mini.ai")
		ai.setup({
			n_lines = 500,
			-- next/last suffixes disabled: an/in shadow treesitter incremental
			-- selection's <CR>/<BS> mappings in nvim-treesitter.lua.
			mappings = {
				around = "a",
				inside = "i",
				around_next = "",
				inside_next = "",
				around_last = "",
				inside_last = "",
				goto_left = "g[",
				goto_right = "g]",
			},
			custom_textobjects = {
				o = ai.gen_spec.treesitter({
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
			},
		})
	end,
}
