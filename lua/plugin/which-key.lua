return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		filter = function(mapping)
			-- gc (comment operator) and <leader>cr (coerce motion) are intentional
			-- prefix+operator patterns; removing them from wk's tree prevents false
			-- overlap warnings while keeping the vim keymaps functional.
			local ignore = { "gc", " cr" }
			return not vim.tbl_contains(ignore, mapping.lhs)
		end,
	},
}
