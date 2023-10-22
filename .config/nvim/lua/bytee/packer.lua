vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- maybe switch to lazyvim
  use 'wbthomason/packer.nvim'

  -- Treesitter
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.3',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Darcula Theme
  use 'Mofiqul/dracula.nvim'
  
  -- Treesitter
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
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
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  use("folke/zen-mode.nvim")
  use("github/copilot.vim")
  use("eandrju/cellular-automaton.nvim")
  use("laytan/cloak.nvim")

  -- Trying them out
  use("theprimeagen/harpoon")
  use("theprimeagen/refactoring.nvim")

end)

