return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/lazydev.nvim" },
    { "mason-org/mason.nvim" },
    { "saghen/blink.cmp" },
  },
  config = function()
    local lsp = vim.lsp
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local mason_lspconfig = require("mason-lspconfig")

    -- Servers excluded from auto-enable: configured manually below, or owned by another plugin
    -- rust_analyzer is managed by rustaceanvim
    local excluded_servers = {
      "azure_pipelines_ls",
      "cssls",
      "lua_ls",
      "nixd",
      "oxlint",
      "rust_analyzer",
      "tailwindcss",
      "yamlls",
    }

    -- Default handler for installed servers
    local servers = mason_lspconfig.get_installed_servers()
    for _, server in pairs(servers) do
      if not vim.tbl_contains(excluded_servers, server) then
        lsp.config(server, { capabilities = capabilities })
        lsp.enable({ server })
      end
    end

    -- Config individual language servers
    lsp.config("cssls", {
      capabilities = capabilities,
      settings = {
        css = {
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    })

    lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "Snacks" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    lsp.config("nixd", {
      capabilities = capabilities,
      cmd = { "nixd" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
          formatting = {
            command = { "nixfmt" },
          },
          options = {
            nixos = {
              -- nixos is the host on Flake.nix
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.nixos.options',
            },
          },
        },
      },
    })

    lsp.config("oxlint", {
      capabilities = capabilities,
    })

    lsp.config("yamlls", {
      capabilities = capabilities,
      settings = {
        yaml = {
          schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
        },
      },
    })

    -- azure_pipelines_ls owns Azure Pipelines schema (filetype yaml, started on root marker)
    -- workspace_required: only start when an azure-pipelines.yml root marker exists, so it
    -- doesn't attach to unrelated yaml (e.g. sops) with rootUri=null and crash on initialize
    lsp.config("azure_pipelines_ls", {
      capabilities = capabilities,
      workspace_required = true,
      settings = {
        yaml = {
          schemas = {
            ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
              "azure-pipelines.yml",
              ".azure-pipelines.yml",
              "azure-pipelines/*.yml",
              "**/azure-pipelines*.yml",
            },
          },
        },
      },
    })

    lsp.config("tailwindcss", {
      capabilities = capabilities,
      filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "scss",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
      },
    })

    -- Enable individual language servers
    lsp.enable({ "azure_pipelines_ls", "cssls", "lua_ls", "nixd", "oxlint", "tailwindcss", "yamlls" })

    -- Toggle codebook LSP
    vim.keymap.set("n", "<leader>cb", function()
      local clients = vim.lsp.get_clients({ name = "codebook" })
      if #clients > 0 then
        for _, client in ipairs(clients) do
          for bufnr in pairs(client.attached_buffers) do
            vim.lsp.buf_detach_client(bufnr, client.id)
            vim.diagnostic.reset(vim.lsp.diagnostic.get_namespace(client.id), bufnr)
          end
          client:stop()
        end
        vim.notify("codebook disabled")
      else
        vim.lsp.start({ name = "codebook", cmd = { "codebook-lsp", "serve" }, root_dir = vim.fn.getcwd() })
        vim.notify("codebook enabled")
      end
    end, { desc = "Toggle codebook LSP" })

    -- Mappings
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local map = vim.keymap.set
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "See available code actions"
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostics"
        map("n", "<leader>di", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        map("n", "[d", function()
          vim.diagnostic.jump({ count = -1 })
        end, opts)

        opts.desc = "Go to next diagnostic"
        map("n", "]d", function()
          vim.diagnostic.jump({ count = 1 })
        end, opts)

        opts.desc = "Show documentation for what is under cursor"
        map("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        map("n", "<leader>rs", ":lsp restart<CR>", opts)

        -- Inlay hints on by default; toggle off with <leader>uh when noisy
        -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- if client and client:supports_method("textDocument/inlayHint") then
        --   vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        -- end

        -- Code lens: enable (auto-refreshes internally), run with <leader>cL
        -- if client and client:supports_method("textDocument/codeLens") then
        --   vim.lsp.codelens.enable(true, { bufnr = ev.buf })
        --   opts.desc = "Run code lens"
        --   map("n", "<leader>cL", vim.lsp.codelens.run, opts)
        -- end

        -- Disable builtin LSP document color, nvim-highlight-colors handles this
        -- This comes with nvim v0.12.0
        vim.lsp.document_color.enable(false)
      end,
    })
  end,
}
