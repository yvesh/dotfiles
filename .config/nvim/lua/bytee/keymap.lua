vim.g.mapleader = " "
vim.keymap.set("n", "<leader>x", vim.cmd.Ex)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- i like the idea of using <C-c> to exit insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/bytee/packer.lua<CR>");

vim.keymap.set("n", "<leader>fz", ":Files<CR>", {});
vim.keymap.set("n", "<leader>hp", ":Files $HOME<CR>", {});

vim.keymap.set("n", "<leader>ff", ":Rg<CR>", {});

-- Some helpers
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })

-- Operator pending
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Window navigation
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

