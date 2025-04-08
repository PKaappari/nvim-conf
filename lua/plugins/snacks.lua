--- @module "snacks"
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    dim = {
      enabled = true,
    },
    notify = { enabled = true },
    notifier = { enabled = true },
    git = { enabled = true },
    lazygit = {
      enabled = true,
    },
    indent = {
      animate = {
        duration = 10,
      },
    },
    toggle = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>ba",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Delete all buffers",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete other buffers",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gB",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        vim.print = _G.dd
        vim.notify("Snacks is ready!", vim.log.levels.INFO, { title = "Snacks" })
        Snacks.toggle.dim():map("<leader>zd")
        Snacks.toggle.inlay_hints():map("<leader>zh")
      end,
    })
  end,
}
