-- Basic nvim settings

vim.opt.guicursor = ""

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = true
vim.o.breakindent = true

vim.opt.nu = true
vim.opt.relativenumber = false

-- No swap
vim.opt.swapfile = false
vim.opt.backup = false

-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true


-- Set color scheme
vim.cmd [[colorscheme darcula-solid]]
vim.opt.termguicolors = true

-- Reset background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Set the update time after hitting a key, default is way too slow
vim.opt.updatetime = 50

vim.opt.isfname:append("@-@")

-- Set highlight on search
vim.o.hlsearch = false

-- Share clipboard with OS
vim.o.clipboard = 'unnamedplus'

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
