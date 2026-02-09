return {
  "pmizio/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    single_file_support = false,
    settings = {
      expose_as_code_action = "all",
      typescript_file_preferences = {
        importModuleSpecifierPreference = "non-relative",
        includeCompletionsForModuleExports = true,
      },
    },
  },
}
