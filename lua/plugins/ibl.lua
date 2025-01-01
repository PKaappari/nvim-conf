return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("ibl").setup({
      scope = { enabled = true },
      enabled = true,
      indent = {},
      exclude = {},
    })
  end,
}
