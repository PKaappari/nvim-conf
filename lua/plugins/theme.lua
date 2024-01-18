return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          which_key = true,
          notify = true,
          noice = true,
          alpha = true,
          indent_blankline = {
            enabled = true,
            scope_color = "text", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false,
          },
          mason = true,
          neotree = true,
          telescope = true,
          lsp_trouble = true
        },
        flavour = "mocha"
      })
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    lazy = false,
    after = 'catppuccin',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled      = true,
        theme              = 'catppuccin',
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'packer', 'neo-tree' },
        globalstatus       = true
      },
      extensions = { 'nvim-tree' }
    }
  },
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    version = '*',
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    after = 'catpuccin',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers',
          separator_style = 'slant',
          diagnostics = 'nvim_lsp',
          hover = {
            enabled = true,
            delay = 100,
            reveal = { 'close', }
          },
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
              text_align = "left"
            }
          }
        },
        highlights = require('catppuccin.groups.integrations.bufferline').get(),
      }
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim'
    },
    after = 'catppuccin',
    config = function()
      require('neo-tree').setup {}
    end,
  },
}
