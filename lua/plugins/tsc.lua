return {
  {
    "dmmulroy/tsc.nvim",

    config = function()
      require("tsc").setup({
        auto_start_watch_mode = true,
      })
    end,
  },
  {
    "MunifTanjim/eslint.nvim",
    config = function()
      require("eslint").setup({
        bin = "eslint",
        code_actions = {
          enable = true,
          apply_on_save = {
            enable = true,
            types = { "directive", "problem", "suggestion", "layout" },
          },
          disable_rule_comment = {
            enable = true,
            location = "separate_line", -- or `same_line`
          },
        },
        diagnostics = {
          enable = true,
          report_unused_disable_directives = false,
          run_on = "type", -- or `save`
        },
      })
    end,
  },
}
