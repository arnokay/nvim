return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			show_end_of_buffer = false,
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.subtext0 },
					Comment = { fg = colors.subtext0 },
					GitSignsCurrentLineBlame = { fg = colors.subtext0 },
				}
			end,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				barbar = true,
				mason = true,
				telescope = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
		--		require("arnokay.config.plugins.color-scheme")
	end,
}
