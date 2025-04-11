vim.o.winaltkeys = "no"
-- Set highlight on search
vim.o.hlsearch = true
vim.o.autoindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.eol = true

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
-- local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil
--
-- if in_wsl then
--   vim.api.nvim_exec2(
--     [[
--       let g:clipboard = {
--         \   'name': 'win32yank-wsl',
--         \   'copy': {
--         \      '+': 'win32yank.exe -i --crlf',
--         \      '*': 'win32yank.exe -i --crlf',
--         \    },
--         \   'paste': {
--         \      '+': 'win32yank.exe -o --lf',
--         \      '*': 'win32yank.exe -o --lf',
--         \   },
--         \   'cache_enabled': 0,
--         \ }
--     ]],
--     { output = true }
--   )
-- end

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
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.incsearch = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.scrolloff = 8

vim.o.inccommand = "split"
vim.o.cursorline = true

vim.o.guicursor = "i:ver1,a:blinkon1"
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
