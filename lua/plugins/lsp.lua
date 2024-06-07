return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")

      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "prettierd", "eslint_d" },
        automatic_installation = true,
        handlers = {},
      })
      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.refactoring,
          require("none-ls.diagnostics.eslint_d"),
          require("none-ls.code_actions.eslint_d"),
          require("none-ls.formatting.eslint_d"),
        },
      })
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { "folke/lazydev.nvim", ft = "lua", opts = {} },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      local lsp = require("mason-lspconfig")
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
          exclude = { "<F2>", "<F4>" },
        })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      end)

      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
          spacing = 4,
          prefix = "⚑",
        },
        signs = true,
        update_in_insert = false,
        underline = true,
      })

      lsp.setup({
        ensure_installed = { "lua_ls", "tsserver" },
        handlers = {
          function(server_name)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig[server_name].setup({
              on_attach = function(client, bufnr)
                if client.name ~= "tsserver" then
                  vim.api.nvim_create_autocmd("BufWritePre", {
                    callback = function()
                      vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 5000 })
                    end,
                    group = vim.api.nvim_create_augroup("Formatting", { clear = true }),
                  })
                end
              end,
              capabilities = capabilities,
            })
          end,
          tsserver = function()
            local function organize_imports(bufnr)
              if not bufnr then
                bufnr = vim.api.nvim_get_current_buf()
              end
              local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(bufnr) },
                title = "",
              }
              vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 5000)
            end
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig").tsserver.setup({
              commands = {
                OrganizeImports = {
                  organize_imports,
                  description = "Organize imports",
                },
              },
              on_init = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
              end,
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  callback = function()
                    organize_imports(bufnr)
                    vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 5000 })
                  end,
                  group = vim.api.nvim_create_augroup("Formatting", { clear = true }),
                })
              end,
              capabilities = capabilities,
            })
          end,
          jsonls = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig").jsonls.setup({
              settings = {
                json = {
                  schemas = require("schemastore").json.schemas(),
                  validate = { enable = true },
                  format = { enable = true },
                },
                capabilities = capabilities,
              },
            })
          end,
          cssls = function()
            require("lspconfig").cssls.setup({
              settings = {
                css = {
                  validate = true,
                  lint = {
                    unknownAtRules = "ignore",
                  },
                },
                less = {
                  validate = true,
                  lint = {
                    unknownAtRules = "ignore",
                  },
                },
                scss = {
                  validate = true,
                  lint = {
                    unknownAtRules = "ignore",
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
