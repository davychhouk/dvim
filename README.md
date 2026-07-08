# dvim

A Customized Neovim config (Nvim + Snacks.nvim + lazy.nvim).

<img width="1512" height="947" alt="image" src="https://github.com/user-attachments/assets/52d6060d-7dd5-48cd-a3c2-a2d7f7e968cb" />

## Adoption

Clone into your Neovim config directory:

```sh
git clone https://github.com/davychhouk/dvim ~/.config/nvim
```

Or as a Nix flake input (consumed by [nixdots](https://github.com/davychhouk/nixdots) / [macdots](https://github.com/davychhouk/macdots)):

```nix
inputs.dvim.url = "github:davychhouk/dvim";
```

On first launch, lazy.nvim auto-installs all plugins and treesitter parsers. Mason auto-installs LSP servers, formatters, and DAP adapters.

## Requirements

**Required:**

| Tool                                                          | Purpose                                |
| ------------------------------------------------------------- | -------------------------------------- |
| Neovim >= 0.12                                                | Runtime                                |
| git                                                           | lazy.nvim bootstrap                    |
| [ripgrep](https://github.com/BurntSushi/ripgrep)              | Grep picker (`rg`)                     |
| [fd](https://github.com/sharkdp/fd)                           | File finder                            |
| [lazygit](https://github.com/jesseduffield/lazygit)           | Git TUI (snacks integration)           |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) | Treesitter parser compilation          |
| make + C/C++ compiler                                         | LuaSnip jsregexp + neorg parser builds |
| A [Nerd Font](https://www.nerdfonts.com)                      | Icons                                  |

**Optional:**

| Tool                                                | Purpose                                                         |
| --------------------------------------------------- | --------------------------------------------------------------- |
| [delta](https://github.com/dandavison/delta)        | deltaview.nvim diff rendering                                   |
| Node.js                                             | prettierd / ts_ls and other JS-based mason tools                |
| [uv](https://github.com/astral-sh/uv)               | Python DAP (`dap-python` launches debugpy via `uv run`)         |
| [Codex CLI](https://github.com/openai/codex)        | Codex.nvim terminal integration                                 |
| Rust toolchain                                      | rustaceanvim local builds                                       |
| tmux                                                | vim-tmux-navigator pane switching                               |
| [nixd](https://github.com/nix-community/nixd)       | Nix LSP (enabled in lspconfig, not in mason — install manually) |
| [codebook-lsp](https://github.com/blopker/codebook) | Spell-check LSP toggled by `<leader>cb` (manual install)        |

### Auto-installed via Mason

LSP servers, formatters, linters, and DAP adapters install on first launch — no manual setup needed.

| Type       | Tools                                                                                                                              |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| LSP        | `azure_pipelines_ls`, `bashls`, `cssls`, `gopls`, `html`, `jsonls`, `lua_ls`, `pyright`, `tailwindcss`, `taplo`, `ts_ls`, `yamlls` |
| Formatters | `gofumpt`, `goimports`, `oxfmt`, `prettierd`, `ruff`, `shfmt`, `stylua`, `yamlfmt` (rustfmt via toolchain)                         |
| Linters    | `oxlint`, `ruff`, `selene`, `shellcheck`, `statix`                                                                                 |
| DAP        | `codelldb`, `delve` (rust-analyzer via mason-tool-installer)                                                                       |

## Structure

```
init.lua                  entry point — sets leader, bootstraps lazy, schedules mappings
lua/
  core/
    lazy.lua              lazy.nvim bootstrap + disabled built-ins
    options.lua           vim options, filetype registrations, diagnostics config
    mappings.lua          global keymaps
  plugin/                 one file per plugin spec (auto-imported by lazy)
  config/                 extended configs (snacks sub-modules)
  util/
    icons.lua             icon constants
    mason-status.lua      mason status helpers
snippets/                 filetype snippet files (LuaSnip)
```

## Plugins

### UI

| Plugin                                                                               | Description                                                                                                                          |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| [catppuccin](https://github.com/catppuccin/nvim)                                     | Colorscheme                                                                                                                          |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                         | Statusline                                                                                                                           |
| [noice.nvim](https://github.com/folke/noice.nvim)                                    | Styled cmdline, messages, and popupmenu                                                                                              |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                                  | Dashboard, explorer, indent guides, scroll animation, statuscolumn, notifier, image preview                                          |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                        | Buffer tabs                                                                                                                          |
| [which-key.nvim](https://github.com/folke/which-key.nvim)                            | Keybind popup hints                                                                                                                  |
| [mini.icons](https://github.com/nvim-mini/mini.icons)                                | Icon provider                                                                                                                        |
| [nvim-highlight-colors](https://github.com/davychhouk/nvim-highlight-colors)         | Inline color swatches (personal fork of [brenoprata10/nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)) |
| [vim-highlighturl](https://github.com/itchyny/vim-highlighturl)                      | Underline URLs                                                                                                                       |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Rendered markdown in buffer                                                                                                          |

### Navigation

| Plugin                                                | Description                                               |
| ----------------------------------------------------- | --------------------------------------------------------- |
| [snacks picker](https://github.com/folke/snacks.nvim) | Fuzzy finder for files, buffers, grep, LSP, git, and more |
| [flash.nvim](https://github.com/folke/flash.nvim)     | Jump and search navigation                                |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)  | Folding with LSP/treesitter providers                     |

### Editing

| Plugin                                                        | Description                                      |
| ------------------------------------------------------------- | ------------------------------------------------ |
| [blink.cmp](https://github.com/saghen/blink.cmp)              | Completion engine                                |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                | Snippet engine with custom JS snippets           |
| [mini.surround](https://github.com/nvim-mini/mini.surround)   | Surround text objects                            |
| [mini.pairs](https://github.com/nvim-mini/mini.pairs)         | Auto-pair brackets and quotes                    |
| [mini.splitjoin](https://github.com/nvim-mini/mini.splitjoin) | Toggle args/arrays between single and multi line |
| [mini.ai](https://github.com/nvim-mini/mini.ai)               | Extended text objects                            |
| [mini.align](https://github.com/nvim-mini/mini.align)         | Align text interactively                         |
| [mini.move](https://github.com/nvim-mini/mini.move)           | Move lines and selections                        |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)  | Auto-close and rename HTML tags                  |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)   | Search and replace UI                            |
| [conform.nvim](https://github.com/stevearc/conform.nvim)      | Formatter runner                                 |
| [coerce.nvim](https://github.com/gregorias/coerce.nvim)       | Case coercion (camel, snake, kebab, etc.)        |

### Git

| Plugin                                                            | Description                                  |
| ----------------------------------------------------------------- | -------------------------------------------- |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)       | Inline hunk signs, inline blame, stage hunks |
| [snacks lazygit](https://github.com/folke/snacks.nvim)            | Floating lazygit window                      |
| [deltaview.nvim](https://github.com/kokusenz/deltaview.nvim)      | Delta-powered diff viewer                    |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight and search TODO/FIXME/etc comments |

### LSP & Tooling

| Plugin                                                     | Description                                            |
| ---------------------------------------------------------- | ------------------------------------------------------ |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configs                                     |
| [mason.nvim](https://github.com/mason-org/mason.nvim)      | LSP, linter, and formatter installer                   |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)     | Asynchronous linter runner                             |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim)      | Lua LSP for Neovim config and plugin development       |
| [trouble.nvim](https://github.com/folke/trouble.nvim)      | Diagnostics and LSP results list                       |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)     | Enhanced Rust LSP (rust-analyzer)                      |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap)       | Debug adapter protocol client with UI and virtual text |

### Treesitter

| Plugin                                                                   | Description                          |
| ------------------------------------------------------------------------ | ------------------------------------ |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)    | Syntax highlighting and text objects |
| [tree-sitter-ghostty](https://github.com/bezhermoso/tree-sitter-ghostty) | Ghostty config grammar               |

### Testing

| Plugin                                                             | Description                                                |
| ------------------------------------------------------------------ | ---------------------------------------------------------- |
| [neotest](https://github.com/nvim-neotest/neotest)                 | Test runner with summary, output, and DAP-strategy support |
| [neotest-golang](https://github.com/fredrikaverpil/neotest-golang) | Go adapter (`go test`)                                     |
| [neotest-python](https://github.com/nvim-neotest/neotest-python)   | Python adapter (pytest / unittest)                         |
| [neotest-vitest](https://github.com/marilari88/neotest-vitest)     | JS/TS adapter (Vitest)                                     |

Rust tests run through rustaceanvim's built-in neotest adapter (no extra plugin). Each adapter needs its test tool available in the project (`go`, `pytest`, `vitest`, `cargo`).

### AI

| Plugin                                                      | Description             |
| ----------------------------------------------------------- | ----------------------- |
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration |
| [codex.nvim](https://github.com/johnseth97/codex.nvim)      | Codex CLI integration   |

### Productivity

| Plugin                                                                  | Description                                      |
| ----------------------------------------------------------------------- | ------------------------------------------------ |
| [auto-session](https://github.com/rmagatti/auto-session)                | Automatic session save and restore               |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless pane navigation between Neovim and tmux |
| [quicker.nvim](https://github.com/stevearc/quicker.nvim)                | Better quickfix UI                               |
| [neorg](https://github.com/nvim-neorg/neorg)                            | Note-taking and organization                     |
| [lorem.nvim](https://github.com/derektata/lorem.nvim)                   | Lorem ipsum generator                            |

## Snacks.nvim

[snacks.nvim](https://github.com/folke/snacks.nvim) is the backbone of this config. The following modules are enabled:

| Module         | Description                                                          |
| -------------- | -------------------------------------------------------------------- |
| `animate`      | Smooth animations for UI transitions                                 |
| `bigfile`      | Disables heavy features for large files                              |
| `dashboard`    | Startup screen (see below)                                           |
| `dim`          | Focus the active scope by dimming surrounding code                   |
| `explorer`     | File tree explorer                                                   |
| `git`          | Git utility helpers (`gitbrowse` opens current line/file in browser) |
| `image`        | Inline image preview                                                 |
| `indent`       | Indent scope guides                                                  |
| `input`        | Styled vim.ui.input replacement                                      |
| `lazygit`      | Floating lazygit window                                              |
| `notifier`     | Styled notification system                                           |
| `picker`       | Fuzzy finder (files, grep, LSP, git, and more)                       |
| `profiler`     | Startup and runtime profiler                                         |
| `quickfile`    | Fast file opening before plugins load                                |
| `scope`        | Scope-aware indent/navigation                                        |
| `scratch`      | Persistent filetype scratch buffers                                  |
| `scroll`       | Smooth scrolling                                                     |
| `statuscolumn` | Custom status column (signs, folds, line numbers)                    |
| `terminal`     | Floating/split terminal                                              |
| `toggle`       | Toggleable UI options (see below)                                    |
| `words`        | Auto-show LSP references and jump between them                       |
| `zen`          | Distraction-free zen and zoom modes                                  |

### Dashboard

Custom ASCII "DVIM" banner with a quick-action menu:

| Key | Action       |
| --- | ------------ |
| `r` | Recent files |
| `f` | Find file    |
| `e` | Explorer     |
| `G` | Lazygit      |
| `l` | Lazy         |
| `m` | Mason        |
| `q` | Quit         |

Auto-reopens when the last real buffer is closed.

### Toggles

| Key          | Toggle                |
| ------------ | --------------------- |
| `<leader>us` | Spelling              |
| `<leader>uw` | Line wrap             |
| `<leader>ul` | Line numbers          |
| `<leader>uL` | Relative line numbers |
| `<leader>ud` | Diagnostics           |
| `<leader>uT` | Treesitter            |
| `<leader>uh` | Inlay hints           |
| `<leader>ug` | Indent guides         |
| `<leader>uD` | Dim out-of-scope code |
| `<leader>uz` | Zen mode              |
| `<leader>uc` | Conceallevel          |
| `<leader>ub` | Dark background       |

## Keymaps

- Leader: `<Space>`
- Local leader: `\`

### General

| Key          | Action                             |
| ------------ | ---------------------------------- |
| `jk`         | Exit insert mode                   |
| `<ESC>`      | Clear search highlights            |
| `<S-u>`      | Redo                               |
| `gG`         | Select all                         |
| `<leader>/`  | Toggle comment                     |
| `<leader>rr` | Replace word under cursor (global) |
| `<leader>yc` | Yank, comment, paste current line  |
| `<leader>Q`  | Quit all                           |
| `<leader>R`  | Restart Neovim                     |
| `<leader>ch` | Checkhealth                        |

### Buffers (bufferline)

| Key                                           | Action                              |
| --------------------------------------------- | ----------------------------------- |
| `<Tab>` / `<S-Tab>`                           | Next / prev buffer                  |
| `<leader>bp`                                  | Pick buffer                         |
| `<leader>bn`                                  | New buffer                          |
| `<leader>bcc`                                 | Close buffer (pick)                 |
| `<leader>bca`                                 | Close all buffers                   |
| `<leader>bcl` / `<leader>bcr` / `<leader>bco` | Close buffers left / right / others |
| `<leader>bmn` / `<leader>bmp`                 | Move buffer next / prev             |
| `<leader>btc` / `<leader>btn` / `<leader>btp` | Close / next / prev tab             |

### Window Splits

| Key           | Action           |
| ------------- | ---------------- |
| `<leader>sph` | Split horizontal |
| `<leader>spv` | Split vertical   |
| `<leader>spe` | Equalize splits  |
| `<leader>spx` | Close split      |

### Motion (Flash)

| Key     | Action                          |
| ------- | ------------------------------- |
| `s`     | Flash jump (n/x/o)              |
| `S`     | Flash treesitter jump           |
| `r`     | Remote flash (operator-pending) |
| `R`     | Treesitter search (o/x)         |
| `<C-s>` | Toggle flash in cmdline search  |

### Folds (ufo)

| Key  | Action                                      |
| ---- | ------------------------------------------- |
| `zR` | Open all folds                              |
| `zM` | Close all folds                             |
| `zK` | Peek folded lines (falls back to LSP hover) |

### Treesitter Selection (normal buffers)

| Key    | Action                                          |
| ------ | ----------------------------------------------- |
| `<CR>` | Init node selection / expand to parent (visual) |
| `<BS>` | Shrink to child node (visual)                   |

### Pane Navigation (tmux)

| Key                                   | Action                                                                |
| ------------------------------------- | --------------------------------------------------------------------- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Navigate left / down / up / right across Neovim splits and tmux panes |

### Markdown

| Key          | Action                 |
| ------------ | ---------------------- |
| `<leader>mr` | Enable render-markdown |
| `<leader>mt` | Toggle render-markdown |

### Find / Grep

| Key               | Action                       |
| ----------------- | ---------------------------- |
| `<leader><space>` | Smart find files             |
| `<leader>ff`      | Find files                   |
| `<leader>fg`      | Git files                    |
| `<leader>fr`      | Recent files                 |
| `<leader>fb`      | Buffers                      |
| `<leader>,`       | Buffers                      |
| `<leader>fp`      | Projects                     |
| `<leader>ft`      | TODO comments                |
| `<leader>fc`      | Find config file             |
| `<leader>sg`      | Grep                         |
| `<leader>sw`      | Grep word / visual selection |
| `<leader>sb`      | Buffer lines                 |
| `<leader>sB`      | Grep open buffers            |
| `<leader>sd`      | Diagnostics                  |
| `<leader>sD`      | Buffer diagnostics           |
| `<leader>sss`     | LSP symbols                  |
| `<leader>ssS`     | LSP workspace symbols        |
| `<leader>sR`      | Resume last picker           |
| `<leader>su`      | Undo history                 |
| `<leader>:`       | Command history              |
| `<leader>sk`      | Keymaps                      |
| `<leader>sm`      | Marks                        |

### Git

| Key           | Action                       |
| ------------- | ---------------------------- |
| `<leader>gg`  | Lazygit                      |
| `<leader>gs`  | Git status                   |
| `<leader>gb`  | Git branches                 |
| `<leader>gl`  | Git log                      |
| `<leader>gL`  | Git log line                 |
| `<leader>gd`  | Git diff hunks               |
| `<leader>gS`  | Git stash                    |
| `<leader>gf`  | Git log for file             |
| `<leader>gB`  | Git browse (open in browser) |
| `<leader>ghs` | Stage hunk                   |
| `<leader>ghr` | Reset hunk                   |
| `<leader>ghS` | Stage buffer                 |
| `<leader>ghR` | Reset buffer                 |
| `<leader>ghp` | Preview hunk                 |
| `<leader>ghb` | Blame line                   |
| `<leader>ghd` | Toggle diff this             |
| `]c` / `[c`   | Next / prev hunk             |

### LSP

**Navigation (via snacks picker):**
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gR` | References |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `<C-o>` | Jump back (older position in jumplist) |
| `<C-i>` | Jump forward (newer position in jumplist) |
| `g;` / `g,` | Jump older / newer in change list |
| <code>``</code> / `''` | Jump to position before last jump (exact / line) |

**Buffer-local (on LSP attach):**
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<leader>ca` | Code action (normal + visual) |
| `<leader>cf` | Format buffer / range (normal + visual) |
| `<leader>cL` | Run code lens |
| `<leader>rn` | Rename symbol |
| `<leader>di` | Show line diagnostics (float) |
| `[d` / `]d` | Prev / next diagnostic |
| `<leader>rs` | Restart LSP |
| `<leader>cb` | Toggle codebook LSP (spell checker) |

### Diagnostics & Trouble

| Key          | Action                               |
| ------------ | ------------------------------------ |
| `<leader>tx` | Diagnostics (Trouble)                |
| `<leader>tX` | Buffer diagnostics (Trouble)         |
| `<leader>cs` | Symbols (Trouble)                    |
| `<leader>cl` | LSP definitions/references (Trouble) |
| `<leader>tL` | Location list (Trouble)              |
| `<leader>tQ` | Quickfix list (Trouble)              |

### Debug (DAP)

| Key           | Action                     |
| ------------- | -------------------------- |
| `<leader>dc`  | Start / continue           |
| `<leader>dsi` | Step into                  |
| `<leader>dso` | Step over                  |
| `<leader>dsu` | Step out                   |
| `<leader>db`  | Toggle breakpoint          |
| `<leader>dB`  | Set conditional breakpoint |
| `<leader>dut` | Toggle DAP UI              |
| `<leader>dl`  | Run last                   |

### Testing (neotest)

| Key          | Action                   |
| ------------ | ------------------------ |
| `<leader>tt` | Run nearest test         |
| `<leader>tf` | Run tests in file        |
| `<leader>td` | Debug nearest test       |
| `<leader>tS` | Stop running test        |
| `<leader>tw` | Watch file tests         |
| `<leader>ts` | Toggle test summary      |
| `<leader>to` | Show test output (float) |
| `<leader>tp` | Toggle test output panel |

### UI / Toggles

| Key                   | Action                       |
| --------------------- | ---------------------------- |
| `<leader>e` / `<C-e>` | File explorer                |
| `<leader>z`           | Zen mode                     |
| `<leader>Z`           | Zoom                         |
| `<leader>x`           | Delete buffer                |
| `<leader>X`           | Delete other buffers         |
| `<C-t>`               | Toggle terminal              |
| `<leader>.`           | Scratch buffer               |
| `<leader>S`           | Select scratch buffer        |
| `<leader>N`           | Neovim news                  |
| `<leader>l`           | Open Lazy                    |
| `<leader>ms`          | Open Mason                   |
| `<leader>un`          | Dismiss notifications        |
| `<leader>nt`          | Notification history         |
| `]]` / `[[`           | Jump between word references |
| `<leader>cR`          | Rename file                  |
| `<leader>wr`          | Restore session              |
| `<leader>ws`          | Save session                 |

### Quickfix / Loclist

| Key         | Action                                            |
| ----------- | ------------------------------------------------- |
| `<leader>q` | Toggle quickfix (quicker)                         |
| `<leader>L` | Toggle loclist (quicker)                          |
| `]q` / `[q` | Next / prev quickfix                              |
| `]l` / `[l` | Next / prev loclist                               |
| `>` / `<`   | Expand / collapse quickfix context (in qf window) |

### Search & Replace (grug-far)

| Key           | Action                                     |
| ------------- | ------------------------------------------ |
| `<leader>grs` | Search and replace                         |
| `<leader>grf` | Search and replace in current file         |
| `<leader>grv` | Search and replace within visual selection |
| `<leader>grw` | Search word under cursor                   |

### Diff (Deltaview)

| Key           | Action           |
| ------------- | ---------------- |
| `<leader>dvm` | Toggle DeltaMenu |
| `<leader>dvl` | Toggle DeltaView |
| `<leader>dva` | Toggle Delta     |

### Coerce

| Key                | Action                                                                                |
| ------------------ | ------------------------------------------------------------------------------------- |
| `<leader>cr<case>` | Coerce identifier case (e.g. `crc` camel, `crs` snake, `crk` kebab) — normal + visual |

### AI

**Claude Code**
| Key | Action |
|-----|--------|
| `<leader>ccc` | Toggle Claude |
| `<leader>ccC` | Continue Claude |
| `<leader>ccr` | Resume Claude |
| `<leader>ccf` | Focus Claude |
| `<leader>ccb` | Add current buffer |
| `<leader>ccs` | Send selection to Claude (visual) |
| `<leader>cca` | Accept diff |
| `<leader>ccd` | Deny diff |

### Neorg (`.norg` files)

| Key                                    | Action                                                                   |
| -------------------------------------- | ------------------------------------------------------------------------ |
| `<leader>ni`                           | Open Neorg index                                                         |
| `<leader>nj`                           | Today's journal entry                                                    |
| `<leader>nn`                           | New note                                                                 |
| `<leader>nf`                           | Find notes (picker)                                                      |
| `<leader>ng`                           | Grep notes (picker)                                                      |
| `<CR>`                                 | Follow link (buffer-local)                                               |
| `gO`                                   | Table of contents                                                        |
| `<localleader>td/tu/tp/th/tc/tr/ti/ta` | Task done/undone/pending/on-hold/cancelled/recurring/important/ambiguous |
| `<localleader>lt` / `<localleader>li`  | Toggle / invert list type                                                |
| `<localleader>id`                      | Insert date                                                              |
| `<localleader>cm`                      | Magnify code block                                                       |
