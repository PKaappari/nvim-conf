return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
