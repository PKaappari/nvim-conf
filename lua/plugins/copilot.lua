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
  },
}
