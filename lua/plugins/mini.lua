return {
  {
    "echasnovski/mini.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "VeryLazy",
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
