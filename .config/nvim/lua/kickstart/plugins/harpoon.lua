return {
  setup = function()
    require('harpoon').setup {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    }
  end,
  config = function()
    vim.keymap.set('n', '<leader>h', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true, silent = true })
  end,
}
