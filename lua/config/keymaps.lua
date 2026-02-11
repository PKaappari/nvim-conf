local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- Keep cursor position when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Better paste (don't overwrite register)
map("x", "p", [["_dP]], { desc = "Paste without overwriting register" })

-- Diagnostics navigation
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })

-- Buffer navigation
map("n", "<A-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<A-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Tab navigation
map("n", "<A-j>", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<A-k>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
