local constants = require("general.constants")
math.randomseed(os.time())

require("tokyodark").setup({
	transparent_background = false, -- set background to transparent
	gamma = 0.93, -- adjust the brightness of the theme
	styles = {
		comments = { italic = true }, -- style for comments
		keywords = { italic = true }, -- style for keywords
		identifiers = { italic = true }, -- style for identifiers
		functions = {}, -- style for functions
		variables = {}, -- style for variables
	},
	custom_highlights = {} or function(highlights, palette)
		return {}
	end, -- extend highlights
	custom_palette = {} or function(palette)
		return {}
	end, -- extend palette
	terminal_colors = true, -- enable terminal colors
})

vim.cmd([[colorscheme tokyodark]])

require("gitsigns").setup({})

require("trouble").setup({})

local navic = require("nvim-navic")
local icons = constants.icons
local galaxyline = require("galaxyline")
local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")
local gls = galaxyline.section
galaxyline.short_line_list = { "NvimTree", "vista", "dbui", "packer", "lspsagaoutline" }

gls.left[1] = {
	RainbowRed = {
		provider = function()
			return "▮ "
		end,
		highlight = { colors.blue, colors.bg },
	},
}

gls.left[2] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {
				["!"] = colors.red,
				[""] = colors.blue,
				[""] = colors.orange,
				["r?"] = colors.cyan,
				c = colors.magenta,
				ce = colors.red,
				cv = colors.red,
				i = colors.green,
				ic = colors.yellow,
				n = colors.red,
				no = colors.red,
				r = colors.cyan,
				R = colors.violet,
				rm = colors.cyan,
				Rv = colors.violet,
				s = colors.orange,
				S = colors.orange,
				t = colors.red,
				v = colors.blue,
				V = colors.blue,
			}
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
			return "  "
		end,
	},
}

gls.left[3] = {
	FileSize = {
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg },
		provider = "FileSize",
	},
}

gls.left[4] = {
	FileIcon = {
		condition = condition.buffer_not_empty,
		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
		provider = "FileIcon",
	},
}

gls.left[5] = {
	FileName = {
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg, "bold" },
		provider = "FileName",
	},
}

gls.left[6] = {
	LineInfo = {
		highlight = { colors.fg, colors.bg },
		provider = "LineColumn",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[7] = {
	PerCent = {
		highlight = { colors.fg, colors.bg, "bold" },
		provider = "LinePercent",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[8] = {
	DiagnosticError = {
		highlight = { colors.red, colors.bg },
		icon = "  ",
		provider = "DiagnosticError",
	},
}

gls.left[9] = {
	DiagnosticWarn = {
		highlight = { colors.yellow, colors.bg },
		icon = "  ",
		provider = "DiagnosticWarn",
	},
}

gls.left[10] = {
	DiagnosticHint = {
		highlight = { colors.cyan, colors.bg },
		icon = "  ",
		provider = "DiagnosticHint",
	},
}

gls.left[11] = {
	DiagnosticInfo = {
		highlight = { colors.blue, colors.bg },
		icon = "  ",
		provider = "DiagnosticInfo",
	},
}

gls.left[12] = {
	nvimNavic = {
		provider = function()
			return navic.get_location()
		end,
		condition = function()
			return navic.is_available()
		end,
	},
}

gls.mid[1] = {
	ShowLspClient = {
		condition = function()
			local tbl = { ["dashboard"] = true, [""] = true }
			if tbl[vim.bo.filetype] then
				return false
			end
			return true
		end,
		highlight = { colors.yellow, colors.bg, "bold" },
		icon = " LSP:",
		provider = "GetLspClient",
	},
}

gls.right[1] = {
	FileEncode = {
		condition = condition.hide_in_width,
		highlight = { colors.green, colors.bg, "bold" },
		provider = "FileEncode",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.right[2] = {
	FileFormat = {
		condition = condition.hide_in_width,
		highlight = { colors.green, colors.bg, "bold" },
		provider = "FileFormat",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.right[3] = {
	GitIcon = {
		provider = function()
			return "  "
		end,
		condition = condition.check_git_workspace,
		highlight = { colors.violet, colors.bg, "bold" },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.right[4] = {
	GitBranch = {
		condition = condition.check_git_workspace,
		highlight = { colors.violet, colors.bg, "bold" },
		provider = "GitBranch",
	},
}

gls.right[5] = {
	Separator = {
		highlight = { colors.fg, colors.bg, "bold" },
		provider = function()
			return " "
		end,
	},
}

gls.right[6] = {
	DiffAdd = {
		condition = condition.hide_in_width,
		highlight = { colors.green, colors.bg },
		icon = "  ",
		provider = "DiffAdd",
	},
}

gls.right[7] = {
	DiffModified = {
		condition = condition.hide_in_width,
		highlight = { colors.orange, colors.bg },
		icon = " 柳",
		provider = "DiffModified",
	},
}

gls.right[8] = {
	DiffRemove = {
		condition = condition.hide_in_width,
		highlight = { colors.red, colors.bg },
		icon = "  ",
		provider = "DiffRemove",
	},
}

gls.right[9] = {
	RainbowBlue = {
		provider = function()
			return "▮"
		end,
		highlight = { colors.blue, colors.bg },
	},
}

gls.short_line_left[1] = {
	BufferType = {
		highlight = { colors.blue, colors.bg, "bold" },
		provider = "FileTypeName",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.short_line_left[2] = {
	SFileName = {
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg, "bold" },
		provider = "SFileName",
	},
}

gls.short_line_right[1] = {
	BufferIcon = {
		highlight = { colors.fg, colors.bg },
		provider = "BufferIcon",
	},
}

require("lspsaga").init_lsp_saga({
	border_style = "plus",
	error_sign = icons.error,
	warn_sign = icons.warning,
	hint_sign = icons.hint,
	definition_preview_icon = "  ",
	rename_prompt_prefix = "➤",
	max_preview_lines = 50,
})

require("bufferline").setup({
	options = {
		view = "default",
		numbers = function(opts)
			return opts.id .. "."
		end,
		buffer_close_icon = icons.close,
		modified_icon = icons.modified,
		left_trunc_marker = icons.left,
		right_trunc_marker = icons.right,
		max_name_length = 18,
		max_prefix_length = 15,
		tab_size = 20,
		diagnostics = "nvim_lsp",
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "thin",
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		sort_by = "extension",
	},
})

require("lspkind").init({
	mode = "symbol_text",
	preset = "codicons",
	symbol_map = {
		Text = "",
		Method = "ƒ",
		Function = "",
		Constructor = "",
		Variable = "襁",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Field = "",
		Unit = "",
		Value = "",
		Enum = "缾",
		Keyword = "",
		Snippet = "﬌",
		Color = "",
		File = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Reference = "",
		Event = "鬒",
		Operator = "Ψ",
	},
})
