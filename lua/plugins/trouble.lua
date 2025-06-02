return {
  "folke/trouble.nvim",
  -- dependencies = { "echasnovski/mini.nvim" },
  cmd = "Trouble",
  opts = {},
  keys = {
    {
      "<leader>td",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>tt",
      "<cmd>Trouble todo toggle<cr>",
      desc = "Todo (Trouble)",
    },
  },
}
