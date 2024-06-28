return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			go = { "golangcilint" },
			lua = { "luacheck" },
		}

		local function has_eslint_config()
			local files = {
				"eslint.config.js",
        "eslint.config.mjs"
			}
			for _, file in ipairs(files) do
				if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. file) == 1 then
					return true
				end
			end
			return false
		end

		if has_eslint_config() then
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end
	end,
}
