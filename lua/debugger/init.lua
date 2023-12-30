local dap = require("dap")

require("mason-nvim-dap").setup({
	ensure_installed = { "python", "cppdbg", "rust", "delve", "js", "node2" },
	automatic_setup = true,
})
