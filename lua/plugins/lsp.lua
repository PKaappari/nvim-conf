return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },

  -- eslint_d code actions
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvimtools/none-ls.nvim", "nvimtools/none-ls-extras.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "eslint_d", "prettierd" },
        automatic_installation = true,
      })
      require("null-ls").setup({
        sources = { require("none-ls.code_actions.eslint_d") },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "jsonls",
            "docker_compose_language_service",
            "cssls",
            "pyright",
            "ruff",
            "bashls",
          },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local function map(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("<leader>dh", vim.lsp.buf.document_highlight, "[D]ocument [H]ighlight")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight", event.buf) then
            local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
              end,
            })
          end
        end,
      })

      -- Server configurations (merged with defaults from nvim-lspconfig)
      vim.lsp.config.lua_ls = {
        settings = {
          Lua = { completion = { callSnippet = "Replace" } },
        },
      }

      vim.lsp.config.jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
            format = { enable = true },
          },
        },
      }

      vim.lsp.config.cssls = {
        settings = {
          css = { validate = true, lint = { unknownAtRules = "ignore" } },
          less = { validate = true, lint = { unknownAtRules = "ignore" } },
          scss = { validate = true, lint = { unknownAtRules = "ignore" } },
        },
      }

      vim.lsp.config.pyright = {
        settings = {
          python = {
            analysis = {
              autoImportCompletions = true,
              diagnosticMode = "workspace",
            },
          },
        },
      }

      -- Servers with no custom config use defaults from nvim-lspconfig
      vim.lsp.enable({
        "lua_ls",
        "jsonls",
        "docker_compose_language_service",
        "cssls",
        "pyright",
        "ruff",
        "bashls",
      })
    end,
  },
}
