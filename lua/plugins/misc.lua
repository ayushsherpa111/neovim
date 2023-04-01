require("lsp-rooter").setup({})
require("Comment").setup()
require("nvim-autopairs").setup({})
require("presence"):setup({
	main_image = "file",
})

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = false,
	update_focused_file = {
		enable = true,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	renderer = {
		highlight_git = true,
		indent_markers = {
			enable = true,
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "▲",
			error = "🗙",
		},
	},
	filters = {
		dotfiles = true,
		custom = {},
	},
})

require("formatter").setup({
	filetype = {
		python = {
			require("formatter.filetypes.python").black,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
			require("formatter.filetypes.go").goimports,
			require("formatter.filetypes.go").gofumpt,
			require("formatter.filetypes.go").golines,
			function()
				return {
					exe = "gofmt",
					args = { "-w" },
					stdin = false,
				}
			end,
		},
		c = {
            require("formatter.filetypes.c").clangformat,
			function()
				return {
					exe = "clang-format",
					args = { "-i", "--style=LLVM" },
					stdin = false,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		yaml = {
			require("formatter.filetypes.javascript").prettier,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		typescript = {
			require("formatter.filetypes.javascript").prettier,
		},
		json = {
			require("formatter.filetypes.javascript").prettier,
		},
		markdown = {
			require("formatter.filetypes.javascript").prettier,
		},
	},
})

local cmd = vim.cmd

cmd([[
    augroup FormatAutogroup
        autocmd!
        autocmd BufWritePre * FormatWrite
    augroup END
]])

-- Start nvim where you left off
cmd([[
    autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])
