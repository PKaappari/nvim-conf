return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
    spec = {
      { "<leader>b", group = "[B]uffer" },
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>f", group = "[F]ind" },
      { "<leader>g", group = "[G]it" },
      { "<leader>h", group = "[H]unk" },
      { "<leader>l", group = "[L]SP" },
      { "<leader>m", group = "[M]ove" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]rouble" },
      { "<leader>u", group = "[U]I" },
      { "<leader>z", group = "[Z]en" },
    },
    defer = function(ctx)
      if vim.list_contains({ "d", "y" }, ctx.operator) then
        return true
      end
      return vim.list_contains({ "<C-V>", "V" }, ctx.mode)
    end,
  },
}
