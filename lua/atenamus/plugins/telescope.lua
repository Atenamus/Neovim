return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
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
				path = "smart",
				picker = {
					find_file = {
						hidden = true,
						themes = "ivy",
					},
				},
				extensions = {
					fzf = {},
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
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("themes")

		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles" }) -- all in the cwd
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
		keymap.set("n", "<leader>en", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "[E]dit [N]eovim" })
		keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
		keymap.set("n", "<leader>fs", require("telescope.builtin").live_grep, { desc = "[F]ind [S]tring" })

		-- Git Keymaps
		keymap.set("n", "<leader>gC", require("telescope.builtin").git_commits, { desc = "[G]it [C]ommits" })
		keymap.set("n", "<leader>gB", require("telescope.builtin").git_branches, { desc = "[G]it [B]ranches" })
		keymap.set("n", "<leader>gS", require("telescope.builtin").git_status, { desc = "[G]it [S]tatus" })
	end,
}
