return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		local macchiato = require("catppuccin.palettes").get_palette("macchiato")
		local snack_picker_hl = { bg = macchiato.base, fg = macchiato.blue }
		require("catppuccin").setup({
			flavour = "macchiato",
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			custom_highlights = function()
				return {
					CursorLine = { bg = macchiato.surface0 },
					DashboardProjectName = { fg = macchiato.sapphire },
					DeltaDiffAddedLine = { link = "DiffAdd" },
					DeltaDiffRemovedLine = { link = "DiffDelete" },
					DeltaDiffAddedWord = { bg = macchiato.green, fg = macchiato.base },
					DeltaDiffRemovedWord = { bg = macchiato.red, fg = macchiato.base },
					DeltaLineNrAdded = { fg = macchiato.green },
					DeltaLineNrRemoved = { fg = macchiato.red },
					DeltaLineNrContext = { fg = macchiato.overlay0 },
					DeltaTitle = { fg = macchiato.sapphire, bold = true },
					FloatBorder = { bg = macchiato.base, fg = macchiato.blue },
					NormalFloat = { bg = macchiato.base, fg = macchiato.text },
					OffsetCustom = { bg = macchiato.base, fg = macchiato.sapphire },
					SnacksPickerBorder = snack_picker_hl,
					SnacksPickerBoxTitle = snack_picker_hl,
					SnacksPickerInputTitle = snack_picker_hl,
					SnacksPickerPreviewTitle = snack_picker_hl,
				}
			end,
			float = {
				transparent = false, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			no_italic = true,
			no_bold = true,
			auto_integrations = false,
			integrations = {
				blink_cmp = true,
				dap = true,
				dap_ui = true,
				flash = true,
				gitsigns = true,
				grug_far = true,
				lsp_trouble = true,
				markdown = true,
				mason = true,
				native_lsp = true,
				noice = true,
				render_markdown = true,
				snacks = {
					enabled = true,
					indent_scope_color = "sapphire",
				},
				treesitter = true,
				ufo = true,
				which_key = true,
			},
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
