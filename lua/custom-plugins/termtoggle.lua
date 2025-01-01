local M = {}

local state = {
  opts = {},
  buf = -1,
  win = -1,
}

-- Function to create a floating terminal
local function create_floating_window()
  local width = state.opts.width or math.floor(vim.o.columns * 0.8)
  local height = state.opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a new buffer if it doesn't exist
  if not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }
  -- Open new window
  state.win = vim.api.nvim_open_win(state.buf, true, win_config)
  if vim.bo[state.buf].buftype ~= "terminal" then
    vim.cmd.terminal()
  end

  -- set keymaps for buffer
  vim.api.nvim_buf_set_keymap(state.buf, "t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
  vim.api.nvim_set_option_value("buflisted", false, { buf = state.buf })
end

-- Function to toggle the floating terminal
function M.toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.win) then
    create_floating_window()
  else
    vim.api.nvim_win_hide(state.win)
  end
end

-- Set up a command for the plugin
function M.setup(opts)
  state.opts = opts or {}
  vim.api.nvim_create_user_command("ToggleTerm", M.toggle_terminal, {})
end

return M
