return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				json = { "prettier" },
				jsonc = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				shell = { "shfmt" },
				bash = { "shfmt" },
				toml = { "taplo" },
			},
		},
	},
}
