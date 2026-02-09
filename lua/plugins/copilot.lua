return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
        },
        panel = {
          enabled = false,
        },
      })

      local suggestion = require("copilot.suggestion")
      vim.keymap.set("i", "<C-l>", suggestion.accept, { desc = "Accept Copilot suggestion" })
      vim.keymap.set("i", "<C-h>", suggestion.next, { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-j>", suggestion.prev, { desc = "Previous Copilot suggestion" })
      vim.keymap.set("i", "<C-k>", suggestion.dismiss, { desc = "Dismiss Copilot suggestion" })
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",
    opts = {},
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat toggle" },
      {
        "<leader>ce",
        "<cmd>CopilotChatExplain<cr>",
        mode = { "n", "v" },
        desc = "Copilot explain",
      },
      {
        "<leader>cr",
        "<cmd>CopilotChatReview<cr>",
        mode = { "n", "v" },
        desc = "Copilot review",
      },
      {
        "<leader>cf",
        "<cmd>CopilotChatFix<cr>",
        mode = { "n", "v" },
        desc = "Copilot fix",
      },
      {
        "<leader>co",
        "<cmd>CopilotChatOptimize<cr>",
        mode = { "n", "v" },
        desc = "Copilot optimize",
      },
      {
        "<leader>ct",
        "<cmd>CopilotChatTests<cr>",
        mode = { "n", "v" },
        desc = "Copilot generate tests",
      },
    },
  },
}
