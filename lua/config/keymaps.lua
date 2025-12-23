local set = vim.keymap.set

-- clear search highlights
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- keybinds to make split navigation easier
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- move visual block vertically
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- paste over something without losing your yank(clipboard)
set("x", "<leader>p", [["_dP]])
-- Delete text without affecting your yank
set({ "n", "v" }, "<leader>d", '"_d')

-- press < multiple times to keep shifting left without losing your selection
set("v", "<", "<gv")
-- press > repeatedly to indent multiple times without having to reselect the text
set("v", ">", ">gv")

-- navigate buffers with arrow keys
set("n", "<Right>", ":bnext<CR>")
set("n", "<Left>", ":bprevious<CR>")

-- escape from insert mode on jj
-- use better escape plugin to avoid delay
-- set("i", "jj", "<ESC>")
