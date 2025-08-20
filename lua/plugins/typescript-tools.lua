return {
  "pmizio/typescript-tools.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local nvim_lsp = require("lspconfig")
    require("typescript-tools").setup({
      root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
      single_file_support = false,
      settings = {
        expose_as_code_action = "all",
        typescript_file_preferences = {
          importModuleSpecifierPreference = "non-relative",
          includeCompletionsForModuleExports = true,
        },
      },
    })
  end,
}
