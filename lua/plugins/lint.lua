return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters.luacheck = vim.tbl_extend(
      "force",
      {},
      lint.linters.luacheck,
      { args = { "--globals", "vim", "lvim", "reload", "--" } }
    )

    lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostics)
      if diagnostics.message:find("Error: Could not find config file") then
        return nil
      end
      return diagnostics
    end)

    lint.linters_by_ft = {
      markdown = { "markdownlint" },
      lua = { "luacheck" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascriptreact = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "CursorHold", "CursorHoldI" }, {
      group = lint_augroup,
      callback = function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })

    vim.api.nvim_create_user_command("Lint", function()
      if vim.opt_local.modifiable:get() then
        lint.try_lint()
      end
    end, {})
  end,
}
