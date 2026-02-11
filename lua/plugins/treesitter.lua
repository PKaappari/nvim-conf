return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    { "windwp/nvim-ts-autotag", opts = {} },
  },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "lua",
      "typescript",
      "tsx",
      "javascript",
      "python",
      "json",
      "html",
      "css",
      "bash",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "yaml",
      "toml",
    },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Around function" },
          ["if"] = { query = "@function.inner", desc = "Inside function" },
          ["ac"] = { query = "@class.outer", desc = "Around class" },
          ["ic"] = { query = "@class.inner", desc = "Inside class" },
          ["aa"] = { query = "@parameter.outer", desc = "Around argument" },
          ["ia"] = { query = "@parameter.inner", desc = "Inside argument" },
          ["ai"] = { query = "@conditional.outer", desc = "Around conditional" },
          ["ii"] = { query = "@conditional.inner", desc = "Inside conditional" },
          ["al"] = { query = "@loop.outer", desc = "Around loop" },
          ["il"] = { query = "@loop.inner", desc = "Inside loop" },
        },
      },
      move = {
        enable = true,
        goto_next_start = {
          ["]f"] = { query = "@function.outer", desc = "Next function start" },
          ["]c"] = { query = "@class.outer", desc = "Next class start" },
          ["]a"] = { query = "@parameter.inner", desc = "Next argument" },
        },
        goto_next_end = {
          ["]F"] = { query = "@function.outer", desc = "Next function end" },
          ["]C"] = { query = "@class.outer", desc = "Next class end" },
        },
        goto_previous_start = {
          ["[f"] = { query = "@function.outer", desc = "Previous function start" },
          ["[c"] = { query = "@class.outer", desc = "Previous class start" },
          ["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
        },
        goto_previous_end = {
          ["[F"] = { query = "@function.outer", desc = "Previous function end" },
          ["[C"] = { query = "@class.outer", desc = "Previous class end" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next argument" },
        },
        swap_previous = {
          ["<leader>A"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
        },
      },
    },
  },
}
