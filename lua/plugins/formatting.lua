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

      if filetype == "typescript" or filetype == "typescriptreact" then
        require("typescript-tools.api").organize_imports(true)
      end

      return {
        timeout_ms = 1000,
        lsp_format = "fallback",
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      htmlangular = { "eslint_d" },
      html = { "eslint_d" },
      xml = { "xmlformatter" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      jwk = { "jsonformatter" },
    },
  },
}
