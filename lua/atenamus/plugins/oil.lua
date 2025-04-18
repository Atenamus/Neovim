return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		use_default_keymaps = true,
		float = {
			padding = 5,
			max_width = 0.5,
			max_height = 0.5,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			get_win_title = nil,
			preview_split = "auto",
			override = function(conf)
				return conf
			end,
		},
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name, _)
				return name == ".." or name == ".git"
			end,
		},
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Oil" }),
}
