require("mason-nvim-dap").setup({
	ensure_installed = { "python", "cppdbg", "rust", "delve" },
	automatic_setup = true,
})

require("mason-nvim-dap").setup_handlers()
