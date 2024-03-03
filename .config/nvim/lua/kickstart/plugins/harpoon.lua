return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function()
      local harpoon = require 'harpoon'

      harpoon.setup {
        global_settings = {
          save_on_toggle = true,
          save_on_change = true,
        },
      }
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
    end,
  },
}
