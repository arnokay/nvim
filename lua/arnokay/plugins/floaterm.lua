return {
	"voldikss/vim-floaterm",
	config = function()
		vim.keymap.set("n", "<C-t>", "<cmd>FloatermToggle<cr>")
		vim.keymap.set("t", "<C-t>", "<cmd>FloatermToggle<cr>")
	end,
}
