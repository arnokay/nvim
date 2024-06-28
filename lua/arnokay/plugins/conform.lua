return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofumpt", "goimports-reviser" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
			},
			formatters = {
				eslint_d = {
					condition = function()
						local function has_eslint_config()
							local files = {
								"eslint.config.js",
								"eslint.config.mjs",
							}
							for _, file in ipairs(files) do
								if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. file) == 1 then
									return true
								end
							end
							return false
						end
						return has_eslint_config()
					end,
				},
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 500,
			-- },
		})

		vim.keymap.set("n", "<leader>mp", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end)
	end,
}
