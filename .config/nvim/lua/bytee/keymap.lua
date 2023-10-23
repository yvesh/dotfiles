vim.g.mapleader = " "
vim.keymap.set("n", "<leader>x", vim.cmd.Ex)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/bytee/packer.lua<CR>");

vim.keymap.set("n", "<leader>fz", ":Files<CR>", {});
vim.keymap.set("n", "<leader>hp", ":Files $HOME<CR>", {});

