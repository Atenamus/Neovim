local config = {
	cmd = { vim.fn.extend("~/AppData/Local/nvim-data/mason/bin/jdtls.cmd") },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
