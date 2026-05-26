return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost" },
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 500,
			},
			current_line_blame_formatter = "<author> • <author_time:%b %d, %Y> • <summary>",
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next hunk")
				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev hunk")

				-- Actions
				map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
				map("n", "<leader>ghd", function()
					if vim.wo.diff then
						for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
							local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
							if name:match("^gitsigns:") then
								vim.api.nvim_win_close(win, false)
							end
						end
						vim.cmd("diffoff!")
					else
						gs.diffthis()
					end
				end, "Toggle diff this")

				-- Text object
				map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
			end,
		})

		-- Guard against gitsigns race: in-flight async blame crashes if the
		-- buffer detaches mid-flight (git_obj closed, repo set nil).
		local blame = require("gitsigns.git.blame")
		local run_blame = blame.run_blame
		blame.run_blame = function(obj, ...)
			if not obj or not obj.repo then
				return {}, {}
			end
			return run_blame(obj, ...)
		end
	end,
}
