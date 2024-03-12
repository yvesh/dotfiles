return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<C-t>]],
        insert_mappings = true,
      }
    end,
  },
}
