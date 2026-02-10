vim.o.winaltkeys = "no"
vim.o.winborder = "rounded"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 2000

vim.o.termguicolors = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.scrolloff = 16

vim.o.inccommand = "split"
vim.o.cursorline = true

vim.o.guicursor = "i:ver1,a:blinkon1"
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

local signs = {
  [vim.diagnostic.severity.ERROR] = "󰅙 ",
  [vim.diagnostic.severity.WARN] = "󰀦 ",
  [vim.diagnostic.severity.HINT] = "󰌵 ",
  [vim.diagnostic.severity.INFO] = "󰋼 ",
}

vim.diagnostic.config({
  signs = { text = signs },
  update_in_insert = true,
  underline = true,
  float = {
    border = "rounded",
    format = function(d)
      return ("%s (%s) [%s]"):format(
        d.message,
        d.source,
        d.code or (d.user_data and d.user_data.lsp and d.user_data.lsp.code) or ""
      )
    end,
  },
})

