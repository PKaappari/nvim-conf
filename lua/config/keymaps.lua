vim.keymap.set("n", "<leader>ft", vim.cmd.Neotree, { desc = "[F]ile [T]ree", silent = true })
vim.keymap.set("n", "<leader>fo", vim.cmd.Oil, { desc = "[O]il", silent = true })

vim.keymap.set("n", "<leader>fb", function()
  vim.cmd.Neotree({ "focus", "buffers", "left" })
end, { desc = "[F]ile [B]uffers" })

vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up", silent = true })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result", silent = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result", silent = true })

vim.keymap.set("x", "<leader>p", '"_dp', { desc = "Paste from buffer without copying", silent = true })

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard", silent = true })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard", silent = true })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank to clipboard", silent = true })

-- Next prev buffer
vim.keymap.set("n", "<M-Right>", "<C-I>", { desc = "Cycle Next Buffer", silent = true })
vim.keymap.set("n", "<M-Left>", "<C-O>", { desc = "Cycle Prev Buffer", silent = true })
vim.keymap.set("n", "<C-l>", ":bn<CR>", { desc = "Move to next buffer", silent = true })
vim.keymap.set("n", "<C-h>", ":bp<CR>", { desc = "Move to previous buffer", silent = true })
vim.keymap.set("n", "<leader>mn", vim.cmd.BufferLineMoveNext, { desc = "Move Buffer Next", silent = true })
vim.keymap.set("n", "<leader>mN", vim.cmd.BufferLineMovePrev, { desc = "Move Buffer Prev", silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<bar>bp<CR>", { desc = "Delete buffer", silent = true })
vim.keymap.set("n", "<leader>b!", ":bd!<bar>bp<CR>", { desc = "Delete buffer without saving", silent = true })
vim.keymap.set("n", "<leader>bx", ":%bd|e#<CR>", { desc = "Close other buffers", silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message", silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message", silent = true })
vim.keymap.set(
  "n",
  "<leader>le",
  vim.diagnostic.open_float,
  { desc = "Open floating diagnostic message", silent = true }
)
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Open diagnostics list", silent = true })

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
end, { desc = "[S]earch [F]iles", noremap = true, silent = true })
vim.keymap.set("n", "<CR>", vim.cmd.nohlsearch, { silent = true })
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-l>", "<C-w>l")

-- vim.keymap.set("n", "<leader>tt", function()
--   require("trouble").toggle("diagnostics")
-- end, { desc = "[T]rouble [T]oggle" })
-- vim.keymap.set("n", "<leader>tn", function()
--   require("trouble").next({ skip_groups = true, jump = true })
-- end, { desc = "[T]rouble move to [n]ext" })
-- --
-- vim.keymap.set("n", "<leader>tp" function()
--   require("trouble").prev({ skip_groups = true, jump = true })
-- end, { desc = "[T]rouble move to [p]revious" })
-- --
-- vim.keymap.set("n", "<leader>tf", function()
--   require("trouble").first({ skip_groups = true, jump = true })
-- end, { desc = "[T]rouble move to [f]irst" })
--
-- vim.keymap.set("n", "<leader>tl", function()
--   require("trouble").last({ skip_groups = true, jump = true })
-- end, { desc = "[T]rouble move to [l]ast" })

-- vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "LazyGit" })

vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")
vim.keymap.set({ "t", "n" }, "<leader><CR>", vim.cmd.ToggleTerm)

vim.keymap.set("n", "<leader>x", ":so %<cr>", { silent = true })
