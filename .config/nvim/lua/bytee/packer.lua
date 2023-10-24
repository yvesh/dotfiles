vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- maybe switch to lazyvim
  use 'wbthomason/packer.nvim'

  -- Treesitter
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- FZF, because fast
  use 'junegunn/fzf.vim'

  -- Darcula Theme
  use 'Mofiqul/dracula.nvim'

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/playground")

  -- Code Diagnostics
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        -- custom options
      }
    end
  })

  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("nvim-treesitter/nvim-treesitter-context");

  -- LSP Zero config
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'SirVer/ultisnips' },
      { 'quangnguyen30192/cmp-nvim-ultisnips' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use("folke/zen-mode.nvim")
  use("eandrju/cellular-automaton.nvim")
  use("laytan/cloak.nvim")

  -- Use Copilot setup to configure it
  use("github/copilot.vim")

  -- Trying them out
  use("theprimeagen/harpoon")
  use("theprimeagen/refactoring.nvim")
end)
