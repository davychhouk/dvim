return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local icons = require("util.icons")
		local macchiato = require("catppuccin.palettes").get_palette("macchiato")
		local colors = {
			blue = macchiato.sapphire,
			green = macchiato.green,
			violet = macchiato.lavender,
			yellow = macchiato.yellow,
			red = macchiato.red,
			fg = macchiato.text,
			bg = macchiato.surface0,
			inactive_bg = macchiato.base,
			semilightgray = macchiato.overlay0,
		}
		local custom_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}
		-- configure lualine with modified theme
		local lazy_status = require("lazy.status")
		local mason_status = require("util.mason-status")
		require("lualine").setup({
			options = {
				theme = custom_theme,
				section_separators = {
					left = icons.lualine.HALF_CIRCLE_RIGHT,
					right = icons.lualine.HALF_CIRCLE_LEFT,
				},
				component_separators = {
					left = "",
					right = "",
				},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icon = icons.lualine.VIM,
						separator = {
							left = icons.lualine.HALF_CIRCLE_LEFT,
							right = icons.lualine.HALF_CIRCLE_RIGHT,
						},
					},
				},
				lualine_b = {
					"filetype",
					"branch",
					"diff",
				},
				lualine_c = {
					{
						"diagnostics",
						diagnostics_color = {
							error = { fg = macchiato.red },
							warn = { fg = macchiato.yellow },
							hint = { fg = macchiato.sapphire },
							info = { fg = macchiato.blue },
						},
						symbols = {
							error = icons.diagnostics.ERROR,
							warn = icons.diagnostics.WARN,
							hint = icons.diagnostics.HINT,
							info = icons.diagnostics.INFO,
						},
					},
					"searchcount",
				},
				lualine_x = {
					{
						mason_status.updates,
						cond = mason_status.has_updates,
						color = { fg = macchiato.pink },
						icon = icons.mason.MASON,
						on_click = function()
							vim.cmd("Mason")
						end,
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = macchiato.peach },
						on_click = function()
							vim.cmd("Lazy")
						end,
					},
					{
						"lsp_status",
						icon = {
							icons.lualine.LSP,
							color = { fg = macchiato.lavender },
						},
						ignore_lsp = { "rust_analyzer" },
						show_name = true,
					},
				},
				lualine_y = { "progress" },
				lualine_z = {
					{
						"location",
						separator = {
							left = icons.lualine.HALF_CIRCLE_LEFT,
							right = icons.lualine.HALF_CIRCLE_RIGHT,
						},
					},
				},
			},
		})
	end,
}
