return {
  "lukas-reineke/indent-blankline.nvim",
  version = "v3.5.4",
  event = "VeryLazy",
  config = function()
    require("ibl").setup({
      scope = { enabled = true },
      enabled = true,
      indent = {},
      exclude = {},
    })
  end,
}
