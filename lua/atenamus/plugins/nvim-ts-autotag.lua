return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Ensure dependency is included
	config = function()
		require("nvim-treesitter.configs").setup({
			autotag = {
				enable = true,
				enable_close = true, -- Add any specific options here
			},
		})
	end,
}
