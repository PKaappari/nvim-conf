return {
  "echasnovski/mini.nvim",
  version = "*",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("ts_context_commentstring").setup({
      enable = true,
      enable_autocmd = false,
    })
    local ai = require("mini.ai")
    ai.setup({
      custom_textobjects = {
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      },
    })

    local function jump(obj, direction, side)
      return function()
        ai.move_cursor(side, "a", obj, { search_method = direction })
      end
    end
    vim.keymap.set({ "n", "x", "o" }, "]f", jump("f", "next", "left"), { desc = "Next function start" })
    vim.keymap.set({ "n", "x", "o" }, "[f", jump("f", "prev", "left"), { desc = "Previous function start" })
    vim.keymap.set({ "n", "x", "o" }, "]F", jump("f", "next", "right"), { desc = "Next function end" })
    vim.keymap.set({ "n", "x", "o" }, "[F", jump("f", "prev", "right"), { desc = "Previous function end" })
    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })
    require("mini.sessions").setup({})
    require("mini.icons").setup({})
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
