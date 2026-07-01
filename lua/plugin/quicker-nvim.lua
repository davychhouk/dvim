return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
	-- stylua: ignore
	keys = {
		{ "<leader>q", function() require("quicker").toggle() end,                  desc = "Toggle quickfix" },
		{ "<leader>L", function() require("quicker").toggle({ loclist = true }) end, desc = "Toggle loclist" },
	},
  -- stylua: ignore end
  opts = {
		-- stylua: ignore
		keys = {
			{ ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "Expand quickfix context" },
			{ "<", function() require("quicker").collapse() end,                                                desc = "Collapse quickfix context" },
		},
    -- stylua: ignore end
  },
}
