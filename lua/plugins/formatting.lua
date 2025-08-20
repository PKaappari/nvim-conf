return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fb",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat [B]uffer",
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local filetype = vim.bo[bufnr].filetype
      local disable_filetypes = {}
      local before_save = {
        typescript = {
          command = function(_)
            local tsapi = require("typescript-tools.api")
            tsapi.organize_imports(true)
          end,
        },
        typescriptreact = {
          command = function(_)
            local tsapi = require("typescript-tools.api")
            tsapi.organize_imports(true)
          end,
        },
      }

      local lsp_format_opt
      if disable_filetypes[filetype] then
        lsp_format_opt = "never"
      else
        lsp_format_opt = "fallback"
      end

      if before_save[filetype] then
        before_save[filetype].command(bufnr)
      end

      return {
        timeout_ms = 1000,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      javascriptreact = { "prettierd" },
      htmlangular = { "prettierd" },
      html = { "prettierd" },
      xml = { "xmlformatter" },
    },
  },
}
