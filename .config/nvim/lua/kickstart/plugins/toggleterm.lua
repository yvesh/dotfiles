return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<C-t>]],
        insert_mappings = true,
        direction = 'horizontal',
      }

      function CountTerms()
        local buffers = vim.api.nvim_list_bufs()
        local terminal_count = 0

        for _, buf in ipairs(buffers) do
          if vim.bo[buf].buftype == 'terminal' then
            terminal_count = terminal_count + 1
          end
        end

        return terminal_count
      end

      vim.keymap.set('n', '<leader>tt', function()
        local command = CountTerms() + 1 .. 'ToggleTerm'
        vim.cmd(command)
      end, { desc = 'Create second terminal' })
    end,
  },
}
