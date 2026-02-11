---@module 'snacks'
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<leader><CR>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle terminal",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>ln",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename file",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete other buffers",
    },
    {
      "<leader>ba",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Delete all buffers",
    },

    -- Find
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Find grep",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Find help",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.resume()
      end,
      desc = "Find resume",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Find word under cursor",
    },
    {
      "<leader>fo",
      function()
        Snacks.picker.recent()
      end,
      desc = "Find recent files",
    },
    {
      "<leader>fi",
      function()
        Snacks.picker.icons()
      end,
      desc = "Find icon",
    },

    -- Git
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git status",
    },
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git branches",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git log",
    },

    -- Diagnostics
    {
      "<leader>dd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Document diagnostics",
    },
    {
      "<leader>dw",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Workspace diagnostics",
    },
  },
  ---@type snacks.Config
  opts = {
    animate = { enabled = true, fps = 30, duration = 300, easing = "inOutSine" },
    picker = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    input = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    rename = { enabled = true },
    terminal = { enabled = true },
    lazygit = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
          "████╗  ██║██║   ██║██║████╗ ████║",
          "██╔██╗ ██║██║   ██║██║██╔████╔██║",
          "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
        }, "\n"),
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "recent_files", limit = 5, padding = 1 },
        { section = "startup" },
      },
    },
    statuscolumn = { enabled = true },
  },
}
