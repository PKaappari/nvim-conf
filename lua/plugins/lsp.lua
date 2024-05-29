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
      local augroup = vim.api.nvim_create_augroup("Formatting", {})

      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "prettierd", "refactoring", "eslint_d" },
        automatic_installation = true,
        handlers = {},
      })
      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.refactoring,
          require("none-ls.diagnostics.eslint_d"),
          require("none-ls.code_actions.eslint_d"),
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
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lsp = require("mason-lspconfig")
      local lsp_zero = require("lsp-zero")

      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
          exclude = { '<F2>', '<F4>' },
        })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      end)

      lsp.setup({
        ensure_installed = { "lua_ls", "tsserver", "jsonls", "rust_analyzer" },
        handlers = {
          function(server_name)
            lsp_zero.default_setup(server_name)
            local lspconfig = require("lspconfig")
            lspconfig[server_name].setup({
              on_attach = function(client, bufnr)
                if (server_name ~= 'tsserver' or server_name ~= 'somesass_ls') then
                  lsp_zero.buffer_autoformat(client, bufnr)
                end
              end
            })
          end,
          tsserver = function()
            local function organize_imports()
              local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = "",
              }
              vim.lsp.buf.execute_command(params)
            end
            require("lspconfig").tsserver.setup({
              commands = {
                OrganizeImports = {
                  organize_imports,
                  description = "Organize imports",
                },
              },
              single_file_support = false,
              on_attach = function(client, bufnr)
                vim.api.nvim_clear_autocmds({
                  group = 'Formatting'
                })
                vim.api.nvim_create_autocmd('BufWritePre',
                  {
                    callback = function()
                      organize_imports()
                      vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 5000 })
                    end,
                    group = vim.api.nvim_create_augroup('Formatting', { clear = false })
                  })
              end
            })
          end,
          jsonls = function()
            require("lspconfig").jsonls.setup({
              settings = {
                json = {
                  schemas = require("schemastore").json.schemas(),
                  validate = { enable = true },
                  format = { enable = true },
                },
              },
            })
          end,
          somesass_ls = function()
            require("lspconfig").somesass_ls.setup({
              on_attach = function()
                vim.api.nvim_clear_autocmds({
                  group = 'Formatting'
                })
                vim.api.nvim_create_autocmd('BufWritePre',
                  {
                    callback = function()
                      vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 5000 })
                    end,
                    group = vim.api.nvim_create_augroup('Formatting', { clear = false })
                  })
              end
            })
          end
        },
      })
    end,
  },
}
