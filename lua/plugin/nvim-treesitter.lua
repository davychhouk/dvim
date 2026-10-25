return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- Setup
    local ts = require("nvim-treesitter")
    ts.setup({ auto_install = false })
    local grp = vim.api.nvim_create_augroup("nvim_treesitter", { clear = true })

    -- Register grammars not in the registry. Must run on User TSUpdate:
    -- install() reloads the parsers module, wiping any earlier assignment.
    vim.api.nvim_create_autocmd("User", {
      group = grp,
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
        "kdl",
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

    local selection_maps = {
      { "n", "<CR>", "van", "Init node selection" },
      { "v", "<CR>", "an", "Expand to parent node" },
      { "v", "<BS>", "in", "Shrink to child node" },
    }

    -- Configure treesitter
    vim.api.nvim_create_autocmd("FileType", {
      group = grp,
      callback = function(ev)
        -- Highlighting
        -- Probe the parser so only "no parser" is silent; query errors still surface.
        local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype) or ""
        local ts_ok = vim.treesitter.language.add(lang) == true
        -- Only undo state this autocmd set, never another plugin's highlighter or maps.
        local b = vim.b[ev.buf]
        if ts_ok then
          vim.treesitter.start(ev.buf, lang)
        elseif b.dvim_ts_hl then
          vim.treesitter.stop(ev.buf)
        end
        b.dvim_ts_hl = ts_ok or nil

        -- Preserve filetype indentation when Treesitter has no indent support.
        local indents = ts_ok and vim.treesitter.query.get(lang, "indents")
        local ts_indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        -- yaml's TS indent query mis-indents lists/mappings; keep GetYAMLIndent.
        if indents and vim.bo[ev.buf].filetype ~= "yaml" then
          vim.bo[ev.buf].indentexpr = ts_indentexpr
        elseif vim.bo[ev.buf].indentexpr == ts_indentexpr then
          -- Drop a stale value left by a previous filetype on this buffer.
          vim.bo[ev.buf].indentexpr = ""
        end

        -- Incremental selection: buffer-local on real files so the global
        -- <CR> doesn't shadow the quickfix-window <CR>.
        if ts_ok and vim.bo[ev.buf].buftype == "" then
          for _, m in ipairs(selection_maps) do
            vim.keymap.set(m[1], m[2], m[3], { buffer = ev.buf, remap = true, desc = m[4] })
          end
          b.dvim_ts_maps = true
        elseif b.dvim_ts_maps then
          for _, m in ipairs(selection_maps) do
            -- maparg reads the current buffer, which FileType sets to ev.buf.
            local cur = vim.fn.maparg(m[2], m[1], false, true)
            if cur.buffer == 1 and cur.desc == m[4] then
              vim.keymap.del(m[1], m[2], { buffer = ev.buf })
            end
          end
          b.dvim_ts_maps = nil
        end
      end,
    })
  end,
}
