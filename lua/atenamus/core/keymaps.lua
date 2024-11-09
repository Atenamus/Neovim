vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "[N]o [H]ighlights" })

--window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "[S]plit [E]quals" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "[S]plit close" })

--buffer management

keymap.set("n", "<leader>bo", "<cmd>enew<CR>", { desc = "[B]uffer [O]pen" })
keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "[B]uffer [C]lose" })
keymap.set("n", "<leader>b]", "<cmd>bnext<CR>", { desc = "[B]uffer [N]ext" })
keymap.set("n", "<leader>b[", "<cmd>bprevious<CR>", { desc = "[B]uffer [P]rev" })
