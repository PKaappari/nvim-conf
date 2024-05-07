return {{
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    -- Format on save
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.tsc,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}, {
    "lukas-reineke/lsp-format.nvim",
    config = function ()
      require("lsp-format").setup({})
    end
  }}
