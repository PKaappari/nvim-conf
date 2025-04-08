local M = {}

local deleteBuffer = function(bufnr)
  vim.api.nvim_buf_call(bufnr, function()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if vim.bo[bufnr].modified then
      local choice = vim.fn.confirm("Buffer is modified. Do you want to save it?", "&Yes\n&No\n&Cancel", 2)
      if choice == 1 then
        vim.cmd.write()
      end

      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.cmd("bdelete!" .. bufnr, { force = true })
      end
    else
      if vim.api.nvim_buf_is_valid(bufnr) then
        if bufname == "" then
          return
          -- vim.api.nvim_buf_delete(bufnr, { force = true })
        else
          vim.cmd("bd " .. bufnr, { force = true })
        end
      end
    end
  end)
end

function M.delete(bufnr)
  if bufnr == nil then
    bufnr = vim.api.nvim_get_current_buf()
  end

  deleteBuffer(bufnr)
end

function M.delete_all()
  local bufnr_list = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufnr_list) do
    if vim.api.nvim_buf_is_valid(buf) then
      deleteBuffer(buf)
    end
  end
end

function M.delete_all_except_current()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufnr_list = vim.api.nvim_list_bufs()

  for _, buf in ipairs(bufnr_list) do
    if buf ~= bufnr and vim.api.nvim_buf_is_valid(buf) then
      deleteBuffer(buf)
    end
  end
end

function M.setup()
  vim.api.nvim_create_user_command("BufDel", function(opts)
    M.delete(opts.args)
  end, { nargs = "?", desc = "Delete buffer" })

  vim.api.nvim_create_user_command("BufDelAll", function()
    M.delete_all()
  end, {})

  vim.api.nvim_create_user_command("BufDelAllExceptCurrent", function()
    M.delete_all_except_current()
  end, {})

  vim.keymap.set("n", "<leader>bd", M.delete, { noremap = true, silent = true, desc = "Delete buffer" })
  vim.keymap.set("n", "<leader>ba", M.delete_all, { noremap = true, silent = true, desc = "Delete all buffers" })
  vim.keymap.set(
    "n",
    "<leader>bo",
    M.delete_all_except_current,
    { noremap = true, silent = true, desc = "Delete other buffers" }
  )
end

return M
