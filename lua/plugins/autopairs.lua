return {
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdLineEnter' },
    branch = 'v0.6',
    config = function()
      local autopair = require('nvim-autopairs')
      require('ultimate-autopair').setup({
      })

      for _, i in ipairs(autopair.config.rules) do
        i.key_map = nil
      end
    end
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'InsertEnter', 'CmdLineEnter' },
    config = function()
      require('nvim-ts-autotag').setup {
        autotag = {
          enable = true
        }
      }
    end
  }
}
