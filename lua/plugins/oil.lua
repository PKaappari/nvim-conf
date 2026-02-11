return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "<leader>e", "<cmd>Oil<CR>", desc = "Explorer (oil)" },
    { "-", "<cmd>Oil<CR>", desc = "Explorer (oil)" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["q"] = "actions.close",
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    -- Update imports when files are moved/renamed in oil
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        for _, action in ipairs(event.data.actions) do
          if action.type == "move" then
            Snacks.rename.on_rename_file(action.src_url, action.dest_url)
          end
        end
      end,
    })
  end,
}
