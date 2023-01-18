local dap = require("dap")

require("mason-nvim-dap").setup({
	ensure_installed = { "python", "cppdbg", "rust", "delve" },
	automatic_setup = true,
})

require("mason-nvim-dap").setup_handlers({
	function(source_name)
		-- all sources with no handler get passed here

		-- Keep original functionality of `automatic_setup = true`
		require("mason-nvim-dap.automatic_setup")(source_name)
	end,
	python = function(source_name)
		dap.adapters.python = {
			type = "executable",
			command = "/usr/bin/python3",
			args = {
				"-m",
				"debugpy.adapter",
			},
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					return "/usr/bin/python3"
				end,
			},
		}
	end,
})
