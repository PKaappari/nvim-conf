return {
  {
    "windwp/nvim-autopairs",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
    config = true
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = "v0.6",
    config = function()
      local autopair = require("nvim-autopairs")
      require("ultimate-autopair").setup({})

      for _, i in ipairs(autopair.config.rules) do
        i.key_map = nil
      end
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        }
      })
    end
  },
}
