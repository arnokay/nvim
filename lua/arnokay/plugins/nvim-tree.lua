return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			git = {
				ignore = false,
			},
		})
		local nvimTree = require("nvim-tree.api")
		local function toggle_nvim_tree_focus()
			if nvimTree.tree.is_visible() then
				vim.cmd(":NvimTreeClose")
			else
				vim.cmd(":NvimTreeFocus")
			end
		end

		vim.keymap.set("n", "<leader>pv", toggle_nvim_tree_focus, { silent = true })
	end,
}
