-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  'junegunn/fzf.vim',

  'briones-gabriel/darcula-solid.nvim',

  'folke/trouble.nvim',

  'mbbill/undotree',

  'tpope/vim-fugitive',

  'folke/zen-mode.nvim',
  'github/copilot.vim',

  'eandrju/cellular-automaton.nvim',

  -- { 'akinsho/toggleterm.nvim', version = '*', config = true },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    -- optionally, override the default options:
    config = function()
      require('tailwindcss-colorizer-cmp').setup {
        color_square_width = 2,
      }
    end,
  },

  { 'numToStr/Comment.nvim', opts = {} },

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/cmp',

  -- Default scheme
  -- require 'kickstart/plugins/tokyonight',
  require 'kickstart/plugins/nightowl',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  require 'kickstart/plugins/harpoon',
  require 'kickstart/plugins/toggleterm',

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- put them in the right spots if you want.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
  --
  --  Here are some example plugins that I've included in the kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}

-- vim: ts=2 sts=2 sw=2 et
