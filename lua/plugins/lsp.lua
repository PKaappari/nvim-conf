return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local lsp = require("mason-lspconfig")
      lsp.setup({
        ensure_installed = { "lua_ls", "tsserver", "jsonls" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
    },
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")

      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end

      local servers = {
        tsserver = {},
        lua_ls = {},
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
              format = { enable = true },
            },
          },
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- See `:help K` for why this keymap
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
      end

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup_handlers({
        function(server_name)
          if server_name == "tsserver" then
            lspconfig[server_name].setup({
              capabilities = capabilities,
              settings = servers[server_name].settings,
              on_attach = on_attach,
              commands = {
                OrganizeImports = {
                  organize_imports,
                  description = "Organize imports",
                },
              },
            })
          else
            lspconfig[server_name].setup({
              capabilities = capabilities,
              settings = servers[server_name] ~= nil and servers[server_name].settings or {},
              on_attach = on_attach,
            })
          end
        end,
      })
      --
      -- for server_name, value in pairs(servers) do
      --   if server_name == "tsserver" then
      --     lspconfig[server_name].setup({
      --       capabilities = capabilities,
      --       settings = value.settings,
      --       on_attach = on_attach,
      --       commands = {
      --         OrganizeImports = {
      --           organize_imports,
      --           description = "Organize imports",
      --         },
      --       },
      --     })
      --   else
      --     lspconfig[server_name].setup({
      --       capabilities = capabilities,
      --       settings = value.settings,
      --       on_attach = on_attach,
      --     })
      --   end
      -- end
    end,
  },
}
