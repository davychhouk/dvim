return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/lazydev.nvim" },
    { "mason-org/mason.nvim" },
    -- blink registers its capabilities on vim.lsp.config("*") when it loads
    { "saghen/blink.cmp" },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    local lsp = vim.lsp

    -- Mason-installed servers are enabled by mason-lspconfig (automatic_enable)
    lsp.config("cssls", {
      settings = {
        css = {
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    })

    lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lsp.config("lua_ls", {
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

    lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
        },
      },
    })

    -- filetypes gate keeps this off unrelated yaml; the server requires a workspace URI.
    lsp.config("azure_pipelines_ls", {
      filetypes = { "yaml.azure-pipelines" },
      root_markers = {
        {
          "azure-pipelines.yml",
          "azure-pipelines.yaml",
          ".azure-pipelines.yml",
          ".azure-pipelines.yaml",
          "azure-pipelines",
          ".azure-pipelines",
        },
        ".git",
      },
      workspace_required = true,
      settings = {
        yaml = {
          schemas = {
            ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
              "**/*.yml",
              "**/*.yaml",
            },
          },
        },
      },
    })

    lsp.config("tailwindcss", {
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

    -- Not in mason. kdl-lsp: cargo install --git https://github.com/kdl-org/kdl-rs kdl-lsp
    lsp.enable({ "kdl_lsp", "nixd" })

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
