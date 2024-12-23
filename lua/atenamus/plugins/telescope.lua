return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"andrew-george/telescope-themes",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				themes = {
					light_themes = {
						ignore = true,
						keywords = { "light", "day", "frappe" },
					},
					dark_themes = {
						ignore = false,
						keywords = { "dark", "night", "black" },
					},
					persist = {
						enabled = true,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("themes")
		telescope.load_extension("harpoon")

		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles" }) -- all in the cwd
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[F]ind [R]ecent" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [S]tring" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "[F]ind string under [C]ursor" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odos" })
		keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[] Find existing buffers" })
		keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
		keymap.set(
			"n",
			"<leader>th",
			":Telescope themes<CR>",
			{ noremap = true, silent = true, desc = "[T]heme Select" }
		)
	end,
}
