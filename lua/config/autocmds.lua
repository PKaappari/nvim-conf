local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Resize splits on window resize
autocmd("VimResized", {
  group = augroup("resize-splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last-location", { clear = true }),
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Format and organize imports on save
autocmd("BufWritePre", {
  group = augroup("format-on-save", { clear = true }),
  callback = function(ev)
    local conform_opts = { bufnr = ev.buf, lsp_format = "fallback", timeout_ms = 2000 }
    local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = ev.buf })[1]

    if not client then
      require("conform").format(conform_opts)
      return
    end

    local result = client:request_sync("workspace/executeCommand", {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(ev.buf) },
    })

    if result and result.err then
      vim.notify(result.err.message, vim.log.levels.ERROR)
      return
    end

    require("conform").format(conform_opts)
  end,
})

-- ESLint auto-fix on save
autocmd("BufWritePre", {
  group = augroup("eslint-fix", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_clients({ name = "eslint", bufnr = ev.buf })[1]
    if client then
      client:request_sync("workspace/executeCommand", {
        command = "eslint.applyAllFixes",
        arguments = { { uri = vim.uri_from_bufnr(ev.buf), version = vim.lsp.util.buf_versions[ev.buf] } },
      }, 2000)
    end
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close-with-q", { clear = true }),
  pattern = { "help", "man", "qf", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})
---
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
