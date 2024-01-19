return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				-- TODO: remove if typescript-tools is gonna be good
				-- "tsserver",
				"lua_ls",
        "templ",
        "html",
        "htmx",
        "tailwindcss",
        "bashls"
			},
		})
	end,
}
