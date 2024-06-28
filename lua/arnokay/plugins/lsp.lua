return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
			},
		},
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/neodev.nvim", opts = {} },
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				"tsserver",
				"lua_ls",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					local lspconfig = require("lspconfig")
					local util = require("lspconfig/util")
					lspconfig.gopls.setup({
						capabilities = capabilities,
						cmd = { "gopls" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						root_dir = util.root_pattern("go.work", "go.mod", ".git"),
						settings = {
							gopls = {
								completeUnimported = true,
								usePlaceholders = true,
								analyses = {
									unusedparams = true,
								},
								staticcheck = true,
								gofumpt = true,
							},
						},
					})
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								not vim.loop.fs_stat(path .. "/.luarc.json")
								and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
									documentFormatting = false,
									Lua = {
										runtime = {
											-- Tell the language server which version of Lua you're using
											-- (most likely LuaJIT in the case of Neovim)
											version = "LuaJIT",
										},
										-- Make the server aware of Neovim runtime files
										workspace = {
											checkThirdParty = false,
											library = {
												vim.env.VIMRUNTIME,
												-- "${3rd}/luv/library"
												-- "${3rd}/busted/library",
											},
											-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
											-- library = vim.api.nvim_get_runtime_file("", true)
										},
									},
								})

								client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
							end
							return true
						end,
					})
				end,
			},
		})

		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
				["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
				-- C-b (back) C-f (forward) for snippet placeholder navigation.
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			},
		})
	end,
}
