return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          accept_word = "<C-f>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
    cmd = "CopilotChat",
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", mode = { "n", "v" }, desc = "Chat toggle" },
      { "<leader>ct", function() require("copilot.suggestion").toggle_auto_trigger() end, desc = "Toggle suggestions" },
      { "<leader>ce", "<cmd>CopilotChatExplain<CR>", mode = { "n", "v" }, desc = "Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<CR>", mode = { "n", "v" }, desc = "Review code" },
      { "<leader>cf", "<cmd>CopilotChatFix<CR>", mode = { "n", "v" }, desc = "Fix code" },
      { "<leader>co", "<cmd>CopilotChatOptimize<CR>", mode = { "n", "v" }, desc = "Optimize code" },
      { "<leader>cd", "<cmd>CopilotChatDocs<CR>", mode = { "n", "v" }, desc = "Generate docs" },
      { "<leader>cs", "<cmd>CopilotChatTests<CR>", mode = { "n", "v" }, desc = "Generate tests" },
    },
    opts = {},
  },
}
