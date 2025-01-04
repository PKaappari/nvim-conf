return {
  "kdheepak/lazygit.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("lazygit")

    vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Lazy[G]it" })
  end,
}
