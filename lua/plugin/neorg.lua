return {
  "nvim-neorg/neorg",
  ft = "norg",
  version = "*",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-neorg/lua-utils.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "pysan3/pathlib.nvim",
    "nvim-nio/nvim-nio",
  },
  build = function()
    local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
    vim.fn.mkdir(parser_dir, "p")

    -- macOS bundles, Linux shared objects.
    local function link_flags(out)
      if vim.fn.has("mac") == 1 then
        return "-bundle -undefined dynamic_lookup -o " .. out
      else
        return "-shared -o " .. out
      end
    end

    -- parser.c must be compiled as C: GCC rejects its designated initializers in C++
    -- mode, and `cc`/`c++` may be GCC on macOS too (nix puts it ahead of clang).
    local function build(repo, name, scanner)
      local tmp = vim.fn.tempname()
      vim.fn.system("git clone --depth 1 " .. repo .. " " .. tmp)
      if vim.v.shell_error ~= 0 then
        vim.fn.delete(tmp, "rf")
        vim.notify("Failed to clone " .. repo, vim.log.levels.ERROR)
        return
      end

      local objs = { tmp .. "/parser.o" }
      local out = vim.fn.system("cc -c -fPIC -I" .. tmp .. "/src -o " .. objs[1] .. " " .. tmp .. "/src/parser.c 2>&1")
      local failed = vim.v.shell_error ~= 0

      if not failed and scanner then
        objs[2] = tmp .. "/scanner.o"
        out = vim.fn.system("c++ -c -fPIC -I" .. tmp .. "/src -o " .. objs[2] .. " " .. tmp .. "/src/scanner.cc 2>&1")
        failed = vim.v.shell_error ~= 0
      end

      if not failed then
        local linker = scanner and "c++" or "cc"
        out = vim.fn.system(
          linker .. " " .. link_flags(parser_dir .. "/" .. name .. ".so") .. " " .. table.concat(objs, " ") .. " 2>&1"
        )
        failed = vim.v.shell_error ~= 0
      end

      vim.fn.delete(tmp, "rf")
      if failed then
        vim.notify("Failed to build " .. name .. " parser:\n" .. out, vim.log.levels.ERROR)
      else
        vim.notify(name .. " parser built successfully")
      end
    end

    build("https://github.com/nvim-neorg/tree-sitter-norg", "norg", true)
    build("https://github.com/nvim-neorg/tree-sitter-norg-meta", "norg_meta", false)
  end,
  config = function()
    local function dropbox_path()
      local f = io.open(vim.fn.expand("~/.dropbox/info.json"), "r")
      if not f then
        return vim.fn.expand("~/Dropbox")
      end
      local content = f:read("*a")
      f:close()
      local ok, info = pcall(vim.fn.json_decode, content)
      if not ok then
        return vim.fn.expand("~/Dropbox")
      end
      return (info.personal and info.personal.path)
        or (info.business and info.business.path)
        or vim.fn.expand("~/Dropbox")
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "norg",
      callback = function()
        local map = function(key, plug, desc)
          vim.keymap.set("n", key, plug, { buffer = true, desc = desc })
        end
        map("<CR>", "<Plug>(neorg.esupports.hop.hop-link)", "Follow link")
        map("gO", "<cmd>Neorg toc<CR>", "Neorg TOC")
        map("<LocalLeader>tu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", "Task undone")
        map("<LocalLeader>tp", "<Plug>(neorg.qol.todo-items.todo.task-pending)", "Task pending")
        map("<LocalLeader>td", "<Plug>(neorg.qol.todo-items.todo.task-done)", "Task done")
        map("<LocalLeader>th", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)", "Task on hold")
        map("<LocalLeader>tc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", "Task cancelled")
        map("<LocalLeader>tr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", "Task recurring")
        map("<LocalLeader>ti", "<Plug>(neorg.qol.todo-items.todo.task-important)", "Task important")
        map("<LocalLeader>ta", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", "Task ambiguous")
        map("<LocalLeader>lt", "<Plug>(neorg.pivot.list.toggle)", "Toggle list type")
        map("<LocalLeader>li", "<Plug>(neorg.pivot.list.invert)", "Invert list")
        map("<LocalLeader>id", "<Plug>(neorg.tempus.insert-date)", "Insert date")
        map("<LocalLeader>cm", "<Plug>(neorg.looking-glass.magnify-code-block)", "Magnify code block")
      end,
    })

    vim.g.neorg_workspace = dropbox_path() .. "/neorg"

    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = { config = { default_keybinds = false } },
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = { notes = vim.g.neorg_workspace },
            default_workspace = "notes",
          },
        },
        ["core.journal"] = {
          config = { workspace = "notes" },
        },
        ["core.summary"] = {},
      },
    })
  end,
  keys = {
    { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Neorg index" },
    { "<leader>nj", "<cmd>Neorg journal today<cr>", desc = "Neorg journal today" },
    { "<leader>nn", "<cmd>Neorg new<cr>", desc = "Neorg new note" },
    {
      "<leader>nf",
      function()
        Snacks.picker.files({ cwd = vim.g.neorg_workspace })
      end,
      desc = "Neorg find notes",
    },
    {
      "<leader>ng",
      function()
        Snacks.picker.grep({ cwd = vim.g.neorg_workspace })
      end,
      desc = "Neorg grep notes",
    },
  },
}
