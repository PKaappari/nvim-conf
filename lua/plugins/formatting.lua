return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[L]SP [F]ormat Buffer",
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local filetype = vim.bo[bufnr].filetype

      if filetype == "typescript" or filetype == "typescriptreact" then
        local ok, ts_tools = pcall(require, "typescript-tools.api")
        if ok then
          ts_tools.organize_imports(true)
        end
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
      markdown = { "prettierd" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      jwk = { "jsonformatter" },
    },
  },
}
