return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        integrations = {
          bufferline = true,
          blink_cmp = true,
          gitsigns = true,
          treesitter = true,
          which_key = true,
          notify = true,
          noice = true,
          mason = true,
          lsp_trouble = true,
          snacks = true,
        },
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      extensions = { "oil" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    version = "*",
    opts = {
      options = {
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and "󰅙 "
            or level:match("warning") and "󰀦 "
            or level:match("hint") and "󰌵 "
            or level:match("info") and "󰋼 "
            or ""
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "oil",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
            text_align = "left",
          },
        },
      },
    },
  },
}
