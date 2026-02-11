return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "opencode_output" },
    },
  },
  keys = {
    { "<leader>og", function() require("opencode.api").toggle() end, desc = "Toggle UI" },
    { "<leader>oi", function() require("opencode.api").open_input() end, desc = "Open input" },
    { "<leader>oI", function() require("opencode.api").open_input_new_session() end, desc = "New session" },
    { "<leader>os", function() require("opencode.api").select_session() end, desc = "Select session" },
    { "<leader>o/", function() require("opencode.api").quick_chat() end, mode = { "n", "v" }, desc = "Quick chat" },
  },
  opts = {
    keymap_prefix = "<leader>o",
    default_global_keymaps = false,
  },
}
