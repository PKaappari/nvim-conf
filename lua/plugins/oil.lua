return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nVIm-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      win_options = {
        wrap = true,
      },
      view_options = {
        show_hidden = true,
      },
    })
  end,
}
