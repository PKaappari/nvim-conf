return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>h", group = "Hunks" },
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Copilot" },
      { "<leader>o", group = "OpenCode" },
    },
  },
}
