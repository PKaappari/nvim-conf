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
          cmp = true,
          gitsigns = true,
          treesitter = true,
          which_key = true,
          notify = true,
          noice = true,
          alpha = true,
          mason = true,
          neotree = true,
          lsp_trouble = true,
          snacks = true,
        },
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    lazy = false,
    after = "catppuccin",
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "packer", "neo-tree" },
        globalstatus = true,
      },
      extensions = { "nvim-tree" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    version = "*",
    dependencies = {
      -- {
      --   "nvim-tree/nvim-web-devicons",
      --   config = function()
      --     require("nvim-web-devicons").setup({
      --       override_by_extension = {
      --         ["css"] = {
      --           icon = "",
      --           color = "#00AA98",
      --           name = "Css",
      --         },
      --       },
      --     })
      --   end,
      -- },
    },
    after = "catppuccin",
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = "slant",
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "󰅙 "
              or level:match("warning") and " "
              or level:match("hint") and " "
            return " " .. icon .. count
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
              text_align = "left",
            },
          },
        },
      })
    end,
  },
}
