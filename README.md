# dvim

A Customized Neovim config (Nvim + Snacks.nvim + lazy.nvim).

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

| Tool | Purpose |
|------|---------|
| Neovim >= 0.10 | Runtime |
| git | lazy.nvim bootstrap |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Grep picker (`rg`) |
| [fd](https://github.com/sharkdp/fd) | File finder |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI (snacks integration) |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) | Treesitter parser compilation |
| make + C compiler | LuaSnip jsregexp build |
| A [Nerd Font](https://www.nerdfonts.com) | Icons |

**Optional:**

| Tool | Purpose |
|------|---------|
| [delta](https://github.com/dandavison/delta) | deltaview.nvim diff rendering |
| Node.js | JS/TS LSP servers via mason |
| Python 3 | Python DAP (nvim-dap-python) |
| Rust toolchain | rustaceanvim / rust-analyzer |
| tmux | vim-tmux-navigator pane switching |

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
| Plugin | Description |
|--------|-------------|
| [catppuccin](https://github.com/catppuccin/nvim) | Colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [noice.nvim](https://github.com/folke/noice.nvim) | Styled cmdline, messages, and popupmenu |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Dashboard, explorer, indent guides, scroll animation, statuscolumn, notifier, image preview |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybind popup hints |
| [mini.icons](https://github.com/echasnovski/mini.icons) | Icon provider |
| [nvim-highlight-colors](https://github.com/davychhouk/nvim-highlight-colors) | Inline color swatches |
| [vim-highlighturl](https://github.com/itchyny/vim-highlighturl) | Underline URLs |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Rendered markdown in buffer |

### Navigation
| Plugin | Description |
|--------|-------------|
| [snacks picker](https://github.com/folke/snacks.nvim) | Fuzzy finder for files, buffers, grep, LSP, git, and more |
| [flash.nvim](https://github.com/folke/flash.nvim) | Jump and search navigation |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Folding with LSP/treesitter providers |

### Editing
| Plugin | Description |
|--------|-------------|
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine with custom JS snippets |
| [mini.surround](https://github.com/echasnovski/mini.surround) | Surround text objects |
| [mini.pairs](https://github.com/echasnovski/mini.pairs) | Auto-pair brackets and quotes |
| [mini.splitjoin](https://github.com/echasnovski/mini.splitjoin) | Toggle args/arrays between single and multi line |
| [mini.ai](https://github.com/echasnovski/mini.ai) | Extended text objects |
| [mini.align](https://github.com/echasnovski/mini.align) | Align text interactively |
| [mini.move](https://github.com/echasnovski/mini.move) | Move lines and selections |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-close and rename HTML tags |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Search and replace UI |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter runner |
| [coerce.nvim](https://github.com/gregorias/coerce.nvim) | Case coercion (camel, snake, kebab, etc.) |
| [unnest.nvim](https://github.com/brianhuster/unnest.nvim) | Unwrap/unnest expressions |

### Git
| Plugin | Description |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Inline hunk signs, inline blame, stage hunks |
| [snacks lazygit](https://github.com/folke/snacks.nvim) | Floating lazygit window |
| [deltaview.nvim](https://github.com/kokusenz/deltaview.nvim) | Delta-powered diff viewer |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight and search TODO/FIXME/etc comments |

### LSP & Tooling
| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configs |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP, linter, and formatter installer |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua LSP for Neovim config and plugin development |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics and LSP results list |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Enhanced Rust LSP (rust-analyzer) |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug adapter protocol client with UI and virtual text |

### Treesitter
| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and text objects |
| [tree-sitter-ghostty](https://github.com/bezhermoso/tree-sitter-ghostty) | Ghostty config grammar |

### AI
| Plugin | Description |
|--------|-------------|
| [supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | AI inline completion |
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration |

### Productivity
| Plugin | Description |
|--------|-------------|
| [auto-session](https://github.com/rmagatti/auto-session) | Automatic session save and restore |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless pane navigation between Neovim and tmux |
| [quicker.nvim](https://github.com/stevearc/quicker.nvim) | Better quickfix UI |
| [neorg](https://github.com/nvim-neorg/neorg) | Note-taking and organization |
| [lorem.nvim](https://github.com/derektata/lorem.nvim) | Lorem ipsum generator |

## Snacks.nvim

[snacks.nvim](https://github.com/folke/snacks.nvim) is the backbone of this config. The following modules are enabled:

| Module | Description |
|--------|-------------|
| `animate` | Smooth animations for UI transitions |
| `bigfile` | Disables heavy features for large files |
| `dashboard` | Startup screen (see below) |
| `dim` | Dims inactive windows |
| `explorer` | File tree explorer |
| `git` | Git utilities (browse, diff) |
| `image` | Inline image preview |
| `indent` | Indent scope guides |
| `input` | Styled vim.ui.input replacement |
| `lazygit` | Floating lazygit window |
| `notifier` | Styled notification system |
| `picker` | Fuzzy finder (files, grep, LSP, git, and more) |
| `profiler` | Startup and runtime profiler |
| `quickfile` | Fast file opening before plugins load |
| `scope` | Scope-aware indent/navigation |
| `scratch` | Persistent filetype scratch buffers |
| `scroll` | Smooth scrolling |
| `statuscolumn` | Custom status column (signs, folds, line numbers) |
| `terminal` | Floating/split terminal |
| `toggle` | Toggleable UI options (see below) |
| `words` | Highlight and jump between word references |
| `zen` | Distraction-free zen and zoom modes |

### Dashboard

Custom ASCII "DVIM" banner with a quick-action menu:

| Key | Action |
|-----|--------|
| `r` | Recent files |
| `f` | Find file |
| `e` | Explorer |
| `G` | Lazygit |
| `l` | Lazy |
| `m` | Mason |
| `q` | Quit |

Auto-reopens when the last real buffer is closed.

### Toggles

| Key | Toggle |
|-----|--------|
| `<leader>us` | Spelling |
| `<leader>uw` | Line wrap |
| `<leader>ul` | Line numbers |
| `<leader>uL` | Relative line numbers |
| `<leader>ud` | Diagnostics |
| `<leader>uT` | Treesitter |
| `<leader>uh` | Inlay hints |
| `<leader>ug` | Indent guides |
| `<leader>uD` | Dim inactive windows |
| `<leader>uz` | Zen mode |
| `<leader>uc` | Conceallevel |
| `<leader>ub` | Dark background |

## Keymaps

Leader: `<Space>` — Local leader: `\`

### General
| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<ESC>` | Clear search highlights |
| `<S-u>` | Redo |
| `gG` | Select all |
| `<leader>/` | Toggle comment |
| `<leader>rr` | Replace word under cursor (global) |
| `<leader>yc` | Yank, comment, paste current line |
| `<leader>Q` | Quit all |
| `<leader>R` | Restart Neovim |
| `<leader>ch` | Checkhealth |

### Window Splits
| Key | Action |
|-----|--------|
| `<leader>sph` | Split horizontal |
| `<leader>spv` | Split vertical |
| `<leader>spe` | Equalize splits |
| `<leader>spx` | Close split |

### Find / Grep
| Key | Action |
|-----|--------|
| `<leader><space>` | Smart find files |
| `<leader>ff` | Find files |
| `<leader>fg` | Git files |
| `<leader>fr` | Recent files |
| `<leader>fb` | Buffers |
| `<leader>,` | Buffers |
| `<leader>fp` | Projects |
| `<leader>ft` | TODO comments |
| `<leader>fc` | Find config file |
| `<leader>sg` | Grep |
| `<leader>sw` | Grep word / visual selection |
| `<leader>sb` | Buffer lines |
| `<leader>sB` | Grep open buffers |
| `<leader>sd` | Diagnostics |
| `<leader>sD` | Buffer diagnostics |
| `<leader>sss` | LSP symbols |
| `<leader>ssS` | LSP workspace symbols |
| `<leader>sR` | Resume last picker |
| `<leader>su` | Undo history |
| `<leader>:` | Command history |
| `<leader>sk` | Keymaps |
| `<leader>sm` | Marks |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gs` | Git status |
| `<leader>gb` | Git branches |
| `<leader>gl` | Git log |
| `<leader>gL` | Git log line |
| `<leader>gd` | Git diff hunks |
| `<leader>gS` | Git stash |
| `<leader>gf` | Git log for file |
| `<leader>gB` | Git browse (open in browser) |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage buffer |
| `<leader>ghR` | Reset buffer |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `<leader>ghd` | Toggle diff this |
| `]c` / `[c` | Next / prev hunk |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gR` | References |
| `gI` | Go to implementation |
| `gy` | Go to type definition |

### Diagnostics & Trouble
| Key | Action |
|-----|--------|
| `<leader>tx` | Diagnostics (Trouble) |
| `<leader>tX` | Buffer diagnostics (Trouble) |
| `<leader>cs` | Symbols (Trouble) |
| `<leader>cl` | LSP definitions/references (Trouble) |
| `<leader>tL` | Location list (Trouble) |
| `<leader>tQ` | Quickfix list (Trouble) |

### Debug (DAP)
| Key | Action |
|-----|--------|
| `<leader>dc` | Start / continue |
| `<leader>dsi` | Step into |
| `<leader>dso` | Step over |
| `<leader>dsu` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>dut` | Toggle DAP UI |
| `<leader>dl` | Run last |

### UI / Toggles
| Key | Action |
|-----|--------|
| `<leader>e` / `<A-e>` | File explorer |
| `<leader>z` | Zen mode |
| `<leader>Z` | Zoom |
| `<leader>x` | Delete buffer |
| `<leader>X` | Delete other buffers |
| `<C-t>` | Toggle terminal |
| `<leader>.` | Scratch buffer |
| `<leader>S` | Select scratch buffer |
| `<leader>N` | Neovim news |
| `<leader>l` | Open Lazy |
| `<leader>ms` | Open Mason |
| `<leader>un` | Dismiss notifications |
| `<leader>nt` | Notification history |
| `]]` / `[[` | Jump between word references |
| `<leader>cR` | Rename file |
| `<leader>wr` | Restore session |
| `<leader>ws` | Save session |

### Quickfix / Loclist
| Key | Action |
|-----|--------|
| `]q` / `[q` | Next / prev quickfix |
| `]l` / `[l` | Next / prev loclist |

