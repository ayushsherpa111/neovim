local utils = require("general.helpers")
local keys = require("general.mappings")
local navic = require("nvim-navic")

navic.setup({
	highlight = false,
	separator = " ",
	depth_limit = 0,
	depth_limit_indicator = "..",
	safe_output = false,
})

local servers = {
	"sumneko_lua",
	"rust_analyzer",
	"tsserver",
	"bashls",
	"gopls",
	"jedi_language_server",
	"clangd",
    "sqlls",
}

local etc = {
	"stylua",
	"shellcheck",
	"editorconfig-checker",
	"golines",
	"gotests",
	"impl",
	"misspell",
	"revive",
	"shfmt",
	"eslint_d",
	"js-debug-adapter",
	"go-debug-adapter",
	"jedi-language-server",
}

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

-- only for DAB, Linters and Formatters
require("mason-tool-installer").setup({
	ensure_installed = etc,
})

local cmd = vim.cmd

local function on_attach(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	utils.map({ "<Esc>", [[<C-\><C-n>:lua require'lspsaga.floaterm'.close_float_terminal()<CR>]], mode = "t" })
	cmd([[au CursorHold <buffer> lua require'lspsaga.diagnostic'.show_line_diagnostics()]])

	if client.server_capabilities.document_formatting then
		keys.saga_keys.f = { "<Cmd>lua vim.lsp.buf.formatting()<CR>", "Format text" }
	elseif client.server_capabilities.document_range_formatting then
		keys.saga_keys.f = { "<Cmd>lua vim.lsp.buf.range_formatting()<CR>", "Range format" }
	else
		keys.saga_keys.f = { "<Cmd>:Format<CR>", "Format text" }
	end

	if client.server_capabilities.document_highlight then
		cmd([[
            augroup lsp_document_highlight
                au! * <buffer>
                au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
	end
	keys.general_keys["<Space>"] = keys.saga_keys
    keys.general_keys["<leader>g"] = keys.tele_keys
	require("which-key").register(keys.general_keys)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, value in ipairs(servers) do
	local ls = require("lspconfig")[value]

	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if value == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "_G" },
				},
				completion = {
					callSnippet = "Replace",
				},
			},
		}
	elseif value == "jedi_language_server" then
		opts.settings = {
			Python = {
				completion = {
					callSnippet = "Replace",
				},
			},
		}
	elseif value == "rust_analyzer" then
		opts.settings = {
			Rust = {
				completion = {
					callSnippet = "Replace",
				},
			},
		}
	elseif value == "gopls" then
		opts.settings = {
			gopls = {
				experimentalPostfixCompletions = true,
				analyses = {
					unusedparams = true,
					shadow = true,
				},
				staticcheck = true,
			},
		}
		opts.init_options = {
			usePlaceholders = true,
		}
	end

	ls.setup(opts)
end
