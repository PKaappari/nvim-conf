vim.o.winaltkeys = "no"
-- Set highlight on search
vim.o.hlsearch = true
vim.o.autoindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- WSL clipboard integration
local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

if in_wsl then
  vim.api.nvim_exec(
    [[
      let g:clipboard = {
        \   'name': 'win32yank-wsl',
        \   'copy': {
        \      '+': 'win32yank.exe -i --crlf',
        \      '*': 'win32yank.exe -i --crlf',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o --lf',
        \      '*': 'win32yank.exe -o --lf',
        \   },
        \   'cache_enabled': 0,
        \ }
    ]],
    true
  )
end

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 150
vim.o.timeoutlen = 100

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.incsearch = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.scrolloff = 8

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.json" },
  command = "silent! EslintFixAll",
  group = vim.api.nvim_create_augroup("JsFormattingCommands", {}),
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.js", "*.jsx" },
  command = "OrganizeImports",
  group = vim.api.nvim_create_augroup("JsFormattingCommands", { clear = false }),
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.js", "*.jsx" },
  command = "",
  group = vim.api.nvim_create_augroup("JsFormattingCommands", { clear = false }),
})



vim.o.guicursor = "i:ver1,a:blinkon1"
