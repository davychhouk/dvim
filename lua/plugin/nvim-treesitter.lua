return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Setup
		local ts = require("nvim-treesitter")
		ts.setup({ auto_install = false })

		-- Install parsers async so BufReadPre isn't blocked
		vim.schedule(function()
			ts.install({
				"bash",
				"c",
				"cpp",
				"css",
				"fish",
				"gitignore",
				"go",
				"graphql",
				"html",
				"http",
				"hyprlang",
				"javascript",
				"json",
				"json5",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"python",
				"query",
				"rasi",
				"regex",
				"rust",
				"scss",
				"sql",
				"svelte",
				"terraform",
				"tmux",
				"toml",
				"tsx",
				"typescript",
				"typst",
				"vue",
				"vim",
				"vimdoc",
				"yaml",
			})
		end)

		-- Configure treesitter
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				-- Highlighting
				local ts_ok = pcall(vim.treesitter.start)

				-- Indentation
				-- local ft = vim.bo.filetype
				-- if ft ~= "yaml" then
				--   vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				-- end
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

				-- Incremental selection: buffer-local on real files so the global
				-- <CR> doesn't shadow the quickfix-window <CR>.
				if ts_ok and vim.bo.buftype == "" then
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, remap = true, desc = desc })
					end
					map("n", "<CR>", "van", "Init node selection")
					map("v", "<CR>", "an", "Expand to parent node")
					map("v", "<BS>", "in", "Shrink to child node")
				end
			end,
		})
	end,
}
