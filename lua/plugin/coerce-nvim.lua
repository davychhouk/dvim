return {
	"gregorias/coerce.nvim",
	tag = "v4.1.0",
	event = "VeryLazy",
	config = function()
		local coerce = require("coerce")
		coerce.setup({
			-- The notification function used during error conditions.
			notify = function(...)
				return vim.notify(...)
			end,
			default_mode_keymap_prefixes = {
				normal_mode = "<leader>cr",
				motion_mode = "<leader>cr",
				visual_mode = "<leader>cr",
			},
			-- Set any field to false to disable that mode.
			default_mode_mask = {
				normal_mode = true,
				motion_mode = false,
				visual_mode = true,
			},
		})
	end,
}
