return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	config = function()
		require("barbar").setup({
			sidebar_filetypes = {
				NvimTree = true,
			},
		})
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }
		map("n", "<Tab>", "<Cmd>BufferNext<CR>", opts)
		map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", opts)
		map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
		map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
		map("n", "<C-p>", "<Cmd>BufferPin<CR>", opts)
		map("n", "<C-w>", "<Cmd>BufferClose<CR>", opts)
	end,
}
