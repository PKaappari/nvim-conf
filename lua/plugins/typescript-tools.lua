return {
  "pmizio/typescript-tools.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("typescript-tools").setup({
      settings = {},
      on_attach = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function()
            require("typescript-tools.api").organize_imports(true)
            vim.lsp.buf.format({
              async = false,
              timeout_ms = 5000,
            })
          end,
          group = vim.api.nvim_create_augroup("Formatting", { clear = true }),
        })
      end,
    })
  end,
}
