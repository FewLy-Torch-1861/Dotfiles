return {
	{ "ellisonleao/gruvbox.nvim" },
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_enable_italic = true
		end,
	},
	{ "rose-pine/neovim" },

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "rose-pine",
		},
	},
}
