return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Setup
    local ts = require("nvim-treesitter")
    ts.setup({ auto_install = false })

    -- Register grammars not in the registry. Must run on User TSUpdate:
    -- install() reloads the parsers module, wiping any earlier assignment.
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        local parsers = require("nvim-treesitter.parsers")
        parsers.tmux = {
          ---@diagnostic disable-next-line: missing-fields
          install_info = {
            url = "https://github.com/Freed-Wu/tree-sitter-tmux",
            queries = "queries",
          },
          tier = 3,
        }
        parsers.ghostty = {
          ---@diagnostic disable-next-line: missing-fields
          install_info = {
            url = "https://github.com/bezhermoso/tree-sitter-ghostty",
            queries = "queries/ghostty",
          },
          tier = 3,
        }
      end,
    })

    -- Install parsers async so BufReadPre isn't blocked
    vim.schedule(function()
      ts.install({
        "bash",
        "c",
        "cpp",
        "css",
        "fish",
        "ghostty",
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
        "zig",
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
