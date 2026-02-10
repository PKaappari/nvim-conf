return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("luasnip").setup({})
        require("luasnip.loaders.from_vscode").lazy_load({})
      end,
    },
  },
  version = "1.*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
    },
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    cmdline = {
      enabled = true,
      completion = {
        menu = {
          border = "rounded",
          auto_show = true,
        },
      },
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
        window = { border = "rounded" },
      },
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
    },
  },
}
