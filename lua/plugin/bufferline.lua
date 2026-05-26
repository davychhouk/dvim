return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		-- Colors
		local macchiato = require("catppuccin.palettes").get_palette("macchiato")
		local background = macchiato.base
		local inactive_bg = background
		local inactive_fg = macchiato.subtext0
		local visible_bg = macchiato.surface0
		local visible_fg = macchiato.subtext0
		local selected_bg = macchiato.surface0
		local selected_fg = macchiato.text
		local modified_fg = macchiato.sapphire
		local inactive_set = { fg = inactive_fg, bg = inactive_bg }
		local visible_set = { fg = visible_fg, bg = visible_bg }
		local active_set = { fg = selected_fg, bg = selected_bg }
		-- Icons
		local icons = require("util.icons")
		local signs = {
			error = icons.diagnostics.ERROR,
			warn = icons.diagnostics.WARN,
			hint = icons.diagnostics.HINT,
			info = icons.diagnostics.INFO,
		}
		-- Config
		local bl = require("bufferline")
		bl.setup({
			highlights = {
				background = inactive_set,
				buffer_visible = visible_set,
				buffer_selected = active_set,
				close_button = inactive_set,
				close_button_visible = visible_set,
				close_button_selected = active_set,
				error = inactive_set,
				error_visible = visible_set,
				error_selected = active_set,
				error_diagnostic = { fg = macchiato.red, bg = inactive_bg },
				error_diagnostic_visible = { fg = macchiato.red, bg = visible_bg },
				error_diagnostic_selected = { fg = macchiato.red, bg = selected_bg },
				duplicate = { fg = macchiato.overlay0, bg = inactive_bg },
				duplicate_visible = { fg = macchiato.overlay0, bg = visible_bg },
				duplicate_selected = { fg = macchiato.overlay0, bg = selected_bg },
				fill = { bg = background },
				hint = inactive_set,
				hint_visible = visible_set,
				hint_selected = active_set,
				hint_diagnostic = { fg = macchiato.sapphire, bg = inactive_bg },
				hint_diagnostic_visible = { fg = macchiato.sapphire, bg = visible_bg },
				hint_diagnostic_selected = { fg = macchiato.sapphire, bg = selected_bg },
				indicator_visible = visible_set,
				indicator_selected = active_set,
				info = inactive_set,
				info_visible = visible_set,
				info_selected = active_set,
				info_diagnostic = { fg = macchiato.blue, bg = inactive_bg },
				info_diagnostic_visible = { fg = macchiato.blue, bg = visible_bg },
				info_diagnostic_selected = { fg = macchiato.blue, bg = selected_bg },
				numbers = inactive_set,
				numbers_visible = visible_set,
				numbers_selected = active_set,
				modified = { fg = modified_fg, bg = inactive_bg },
				modified_visible = { fg = modified_fg, bg = visible_bg },
				modified_selected = { fg = modified_fg, bg = selected_bg },
				offset_separator = { bg = background },
				pick = { fg = macchiato.peach, bg = background },
				pick_visible = { fg = macchiato.peach, bg = visible_bg },
				pick_selected = { fg = macchiato.peach, bg = selected_bg },
				separator = { fg = background, bg = inactive_bg },
				separator_visible = { fg = background, bg = visible_bg },
				separator_selected = { fg = background, bg = selected_bg },
				trunc_marker = { fg = macchiato.sapphire, bg = background },
				warning = inactive_set,
				warning_visible = visible_set,
				warning_selected = active_set,
				warning_diagnostic = { fg = macchiato.yellow, bg = inactive_bg },
				warning_diagnostic_visible = { fg = macchiato.yellow, bg = visible_bg },
				warning_diagnostic_selected = { fg = macchiato.yellow, bg = selected_bg },
			},
			options = {
				color_icons = true,
				indicator = { style = "none" },
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diagnostic)
					for type, sign in pairs(signs) do
						if diagnostic[type] then
							return sign
						end
					end
					return ""
				end,
				offsets = {
					{
						filetype = "snacks_layout_box",
						highlight = "OffsetCustom",
						text = icons.snacks.EXPLORER,
						text_align = "left",
						separator = true,
					},
					{
						filetype = "dapui_scopes",
						highlight = "OffsetCustom",
						text = icons.dap.DEBUGGER,
						text_align = "left",
						separator = true,
					},
				},
				separator_style = "thin",
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				style_preset = {
					bl.style_preset.no_italic,
					bl.style_preset.no_bold,
				},
				themable = true,
				truncate_names = false,
				show_tab_indicators = false,
			},
		})
		-- Mappings
		local map = vim.keymap.set
		map("n", "<Tab>", "<CMD>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
		map("n", "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
		map("n", "<leader>bp", "<CMD>BufferLinePick<CR>", { desc = "Pick Buffer" })
		map("n", "<leader>bn", "<CMD>enew<CR>", { desc = "New Buffer" })
    -- stylua: ignore
    map("n", "<leader>bca", function() Snacks.bufdelete.all() end, { desc = "Close All Buffers" })
		-- stylua: ignore end
		map("n", "<leader>bcc", "<CMD>BufferLinePickClose<CR>", { desc = "Close Buffer" })
		map("n", "<leader>bcl", "<CMD>BufferLineCloseLeft<CR>", { desc = "Close Buffers Left" })
		map("n", "<leader>bcr", "<CMD>BufferLineCloseRight<CR>", { desc = "Close Buffers Right" })
		map("n", "<leader>bco", "<CMD>BufferLineCloseOthers<CR>", { desc = "Close Other Buffers" })
		map("n", "<leader>bmn", "<CMD>BufferLineMoveNext<CR>", { desc = "Move Buffer Next" })
		map("n", "<leader>bmp", "<CMD>BufferLineMovePrev<CR>", { desc = "Move Buffer Prev" })
		map("n", "<leader>btc", "<CMD>tabc<CR>", { desc = "Close Tab" })
		map("n", "<leader>btn", "<CMD>tabn<CR>", { desc = "Next Tab" })
		map("n", "<leader>btp", "<CMD>tabp<CR>", { desc = "Prev Tab" })
	end,
}
