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
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        end,
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
        })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      end)
      lsp.setup({
        ensure_installed = { "lua_ls", "tsserver", "jsonls", "rust_analyzer" },
        handlers = {
          function(server_name)
            local lspconfig = require("lspconfig")
            lspconfig[server_name].setup({})
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
        },
      })
    end,
  },
}
