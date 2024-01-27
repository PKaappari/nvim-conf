return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({
      auto_start_watch_mode = true,
    })
  end,
}
