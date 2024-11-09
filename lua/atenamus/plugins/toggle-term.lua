return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	keys = function(_, keys)
		local function toggleterm()
			local venv = vim.b["virtual_env"]
			local term = require("toggleterm.terminal").Terminal:new({
				env = venv and { VIRTUAL_ENV = venv } or nil,
				count = vim.v.count > 0 and vim.v.count or 1,
				cmd = "powershell.exe",
			})
			term:toggle()
		end
		local mappings = {
			{ "<C-/>", mode = { "n", "t" }, toggleterm, desc = "Toggle Terminal" },
			{ "<C-_>", mode = { "n", "t" }, toggleterm, desc = "which_key_ignore" },
		}
		return vim.list_extend(mappings, keys)
	end,
	opts = {
		open_mapping = false,
		float_opts = {
			border = "curved",
		},
	},
}
