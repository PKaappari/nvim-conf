return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  { "mason-org/mason-lspconfig.nvim", config = true },
  { "folke/lazydev.nvim", ft = "lua", opts = {} },
  { "b0o/schemastore.nvim" },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvimtools/none-ls.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("<leader>dh", vim.lsp.buf.document_highlight, "[D]ocument [H]ighlight")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local method = vim.lsp.protocol.Methods.textDocument_documentHighlight
          if client and client.supports_method(client, method, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("detach-highlight", { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
              end,
            })
          end
        end,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
              format = { enable = true },
            },
            jsonc = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
              format = { enable = true },
            },
            yml = {
              schemas = require("schemastore").yaml.schemas(),
              validate = { enable = true },
              format = { enable = true },
            },
            yaml = {
              schemas = require("schemastore").yaml.schemas(),
              validate = { enable = true },
              format = { enable = true },
            },
          },
        },
        cssls = {
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
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
        "eslint_d",
        "prettierd",
      })

      require("mason-null-ls").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })

      require("null-ls").setup({
        sources = {
          require("none-ls.code_actions.eslint_d"),
        },
      })

      for server_name, server in pairs(servers) do
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        vim.lsp.enable(server_name)
        vim.lsp.config[server_name] = server
      end
    end,
  },
}
