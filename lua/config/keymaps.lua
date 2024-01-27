vim.keymap.set("n", "<leader>ft", vim.cmd.Neotree, { desc = "[F]ile [T]ree" })

vim.keymap.set("n", "<leader>fb", function()
  vim.cmd.Neotree({ "focus", "buffers", "left" })
end, { desc = "[F]ile [B]uffers" })

vim.keymap.set("n", "<leader>fg", vim.cmd.DiffviewOpen, { desc = "[G]it Status", silent = true })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result" })

vim.keymap.set("x", "<leader>p", '"_dp', { desc = "Paste from buffer without copying" })

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

-- Next prev buffer
vim.keymap.set("n", "<M-Right>", "<C-I>", { desc = "Cycle Next Buffer" })
vim.keymap.set("n", "<M-Left>", "<C-O>", { desc = "Cycle Prev Buffer" })
vim.keymap.set("n", "<C-l>", ":bn<CR>", { desc = "Move to next buffer", silent = true })
vim.keymap.set("n", "<C-h>", ":bp<CR>", { desc = "Move to previous buffer", silent = true })
vim.keymap.set("n", "<leader>mn", vim.cmd.BufferLineMoveNext, { desc = "Move Buffer Next" })
vim.keymap.set("n", "<leader>mN", vim.cmd.BufferLineMovePrev, { desc = "Move Buffer Prev" })
vim.keymap.set("n", "<leader>bq", ":bp<bar>bd#<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>b!", ":bp<bar>bd!<CR>", { desc = "Delete buffer without saving" })
vim.keymap.set("n", "<leader>bx", ":%bd|e#<CR>", { desc = "Close other buffers" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
end, { desc = "[S]earch [F]iles", noremap = true, silent = true })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

vim.keymap.set("n", "<CR>", vim.cmd.nohlsearch, { silent = true })

vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-l>", "<C-w>l")

vim.keymap.set("n", "<leader>tt", function()
  require("trouble").toggle("workspace_diagnostics")
end, { desc = "[T]rouble [T]oggle" })
vim.keymap.set("n", "<leader>tn", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "[T]rouble move to [n]ext" })

vim.keymap.set("n", "<leader>tp", function()
  require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "[T]rouble move to [p]revious" })

vim.keymap.set("n", "<leader>tf", function()
  require("trouble").first({ skip_groups = true, jump = true })
end, { desc = "[T]rouble move to [f]irst" })

vim.keymap.set("n", "<leader>tl", function()
  require("trouble").last({ skip_groups = true, jump = true })
end, { desc = "[T]rouble move to [l]ast" })

vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "LazyGit" })
