-- TODO: finish configurate mappings
-- local M = {}

local opts = {
	silent = true,
	noremap = true,
}

-- M.global = {
-- n = {
-- ["<leader>pn"] = {
-- ":pu<CR>",
-- "paste after current line"
-- },
-- ["<leader>pp"] = {
-- ":-1pu!<CR>",
-- "paste before current line",
-- },
-- }
-- }

-- paste after current line
vim.keymap.set("n", "<leader>pn", ":pu<CR>", opts)
-- paste before current line
vim.keymap.set("n", "<leader>pp", ":-1pu!<CR>", opts)
-- paste and keep already copied
vim.keymap.set("x", "<leader>p", '"_dP', opts)

-- remap for navigate on tabs
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- move selected text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move line below on the current line and stay in place
vim.keymap.set("n", "J", "mzJ`z")

-- half page jump and center screen
vim.keymap.set("n", "<C-d", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")

-- search and center screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy in system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- delete without copy
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- edit all words that you on right now
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- return M
