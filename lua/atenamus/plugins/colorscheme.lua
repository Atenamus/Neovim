return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
	},
	{
		"marko-cerovac/material.nvim",
		priority = 1000,
	},
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "mix"
		end,
	},
	{
		"dracula/vim",
		name = "dracula",
		priority = 1000,
	},
}
