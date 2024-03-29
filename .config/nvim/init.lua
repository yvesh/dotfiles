-- New config based on kickstart
-- just to migrate to lazy installer
-- v2024-03-29

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = 1

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- [[ Snippets ]]
require 'snippets'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
