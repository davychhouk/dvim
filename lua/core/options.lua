local g = vim.g
local o = vim.o

-- line numbers
o.number = true
o.relativenumber = true

-- tabs & indentation
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2

-- disable default mode for lualine
o.showmode = false

-- disable nvim intro screen (snacks dashboard handles it)
vim.opt.shortmess:append("I")

-- disable word wrap
o.wrap = false

-- keep cursor away from screen edges
o.scrolloff = 8

-- search settings
o.ignorecase = true
o.smartcase = true

-- cursorline highlight
o.cursorline = true

-- disable cursor blink in terminal insert mode
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon0"

-- colorscheme
o.background = "dark"
o.signcolumn = "yes"
o.termguicolors = true

-- persistent undo
o.undofile = true

-- which-key timeout
o.timeout = true
o.timeoutlen = 500

-- clipboard (deferred to avoid slow provider detection on startup)
vim.schedule(function()
  vim.opt.clipboard:append("unnamedplus")
end)

-- split windows
o.splitbelow = true
o.splitright = true

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- filetype registrations
vim.filetype.add({
  extension = { gotmpl = "gotmpl" },
  filename = {
    [".gitlab-ci.yml"] = "yaml.gitlab",
  },
  pattern = {
    [".*/tmux/.*%.conf"] = "tmux",
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    ["compose.*%.ya?ml"] = "yaml.docker-compose",
    ["values%.ya?ml"] = "yaml.helm-values",
    ["%.?azure%-pipelines.*%.ya?ml"] = "yaml.azure-pipelines",
    [".*/%.?azure%-pipelines/.*%.ya?ml"] = "yaml.azure-pipelines",
  },
})

-- diagnostics (deferred, not needed until buffer loads)
vim.schedule(function()
  local i = require("util.icons")
  local x = vim.diagnostic.severity
  vim.diagnostic.config({
    virtual_text = {
      prefix = i.diagnostics.PREFIX,
      virt_text_pos = "eol",
    },
    signs = {
      text = {
        [x.ERROR] = i.diagnostics.ERROR,
        [x.WARN] = i.diagnostics.WARN,
        [x.HINT] = i.diagnostics.HINT,
        [x.INFO] = i.diagnostics.INFO,
      },
    },
    underline = true,
    float = { border = "single" },
  })
end)
