return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "ts_ls",
        "eslint",
        "pyright",
        "ruff",
        "lua_ls",
        "jsonls",
        "cssls",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          map("<leader>ld", function()
            Snacks.picker.lsp_definitions()
          end, "Go to definition")
          map("<leader>lD", vim.lsp.buf.declaration, "Go to declaration")
          map("<leader>lr", function()
            Snacks.picker.lsp_references()
          end, "References")
          map("<leader>li", function()
            Snacks.picker.lsp_implementations()
          end, "Implementation")
          map("<leader>lt", function()
            Snacks.picker.lsp_type_definitions()
          end, "Type definition")
          map("rn", vim.lsp.buf.rename, "Rename")
          map("<leader>la", vim.lsp.buf.code_action, "Code action")
          map("<leader>lh", vim.lsp.buf.hover, "Hover")
          map("<leader>ls", vim.lsp.buf.signature_help, "Signature help")
          map("K", vim.lsp.buf.hover, "Hover")
          map("gd", function()
            Snacks.picker.lsp_definitions()
          end, "Go to definition")
          map("gr", function()
            Snacks.picker.lsp_references()
          end, "References")
        end,
      })

      -- Capabilities for blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Configure servers with vim.lsp.config
      local servers = {
        ts_ls = {},
        eslint = {},
        pyright = {
          settings = {
            pyright = { disableOrganizeImports = true },
            python = {
              analysis = { typeCheckingMode = "basic" },
            },
          },
        },
        ruff = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        jsonls = {},
        cssls = {},
        tailwindcss = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end

      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
