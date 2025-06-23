
local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", { desc = "Move text down" })
keymap("v", "<A-k>", ":m .-2<CR>==", { desc = "Move text up" })

-- Better paste
keymap("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Clear highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlights" })

-- Quick save
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })

---
