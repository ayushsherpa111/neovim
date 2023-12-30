local M = {}

M.general_keys = {
	-- NOTE: Some mappings are assigned in the lspconfig `on_attach` function
	["<Esc>"] = { ":nohlsearch<CR>", "Exit search" },
	["<C-s>"] = { ":%s/\\v", "Replace", silent = false },
	["<leader>h"] = { ":hide<cr>", "Hides buffer." },
	["<C-q>"] = { ":bdelete<CR>", "Delete buffer" },
	["<leader>l"] = {  ":NvimTreeToggle<cr>", "Toggle Nvim Tree" },
	-- Telescope and gitsigns
	["/"] = {
		f = { ":lua require 'telescope.builtin'.live_grep {grep_open_files = true}<CR>", "Search text in open files" },
		F = { ":Telescope live_grep<CR>", "Search text in all files" },
	},
	["\\"] = {
		f = { ":Telescope find_files<CR>", "Search file" },
		h = { ":Telescope search_history<CR>", "Search history" },
		p = { ":Telescope commands<CR>", "Search command" },
		b = { ":Telescope buffers<CR>", "Search buffers" },
	},
	-- Bufferline
	["<A-l>"] = { ":BufferLineCycleNext<CR>", "Next tab" },
	["<A-h>"] = { ":BufferLineCyclePrev<CR>", "Previous tab" },
	["<C-l>"] = { ":wincmd l<CR>", "Navigate right" },
	["<C-h>"] = { ":wincmd h<CR>", "Navigate left" },
	["<C-k>"] = { ":wincmd k<CR>", "Navigate up" },
	["<C-j>"] = { ":wincmd j<CR>", "Navigate down" },
}

M.visual_keys = {
	["<C-s>"] = { ":s/\\v", "Replace selection", mode = "v", silent = false },
}

M.tele_keys = {
	t = { ":Telescope lsp_type_definitions<cr>", "Get Type Definitions" },
	d = { ":Telescope lsp_definitions<cr>", "Get Definitions" },
	r = { ":Telescope lsp_references<cr>", "Get References" },
	i = { ":Telescope lsp_implementations<cr>", "Get Implementations" },
}

M.dap_keys = {
	["b"] = { ":DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
	["c"] = { ":DapContinue<cr>", "Debugger Continue" },
	["t"] = { ":DapToggleRepl<cr>", "Debugger Toggle REPL" },
	["i"] = { ":DapStepInto<cr>", "Debugger Step Into" },
	["O"] = { ":DapStepOut<cr>", "Debugger Step out" },
	["o"] = { ":DapStepOver<cr>", "Debugger Step Over" },
	["k"] = { ":DapTerminate<cr>", "Debugger Terminate" },
}

M.saga_keys = {
	name = "Lsp",
	d = { "<cmd>lua require 'lspsaga.provider'.preview_definition()<CR>", "Preview definition" },
	r = { "<cmd>lua require 'lspsaga.rename'.rename()<CR>", "Rename definition" },
	k = { "<cmd>lua require 'lspsaga.hover'.render_hover_doc()<CR>", "Hover doc" },
	a = { "<cmd>lua require 'lspsaga.codeaction'.code_action()<CR>", "Code action" },
	t = { ":Lspsaga toggle_floaterm<CR>", "Toggle Floating Terminal" },
	e = { ":TroubleToggle<CR>", "Open error summary" },
	q = { ":Trouble quickfix<CR>", "Open quick fix summary" },
	s = { "<cmd>lua require 'lspsaga.provider'.lsp_finder()<CR>", "Lsp finder" },
	h = { "<cmd>lua require 'lspsaga.signaturehelp'.signature_help()<CR>", "Signature help" },
	["]"] = { ":Lspsaga diagnostic_jump_next<CR>", "Go to next diagnostic" },
	["["] = { ":Lspsaga diagnostic_jump_prev<CR>", "Go to previous diagnostic" },
}

M.git_keys = {}

if os.execute("git status > /dev/null") == 0 then
	local keys_git = M.general_keys["\\"]
	keys_git.c = { ":Telescope git_commits<CR>", "Search commit history" }
	keys_git.b = { ":Telescope git_branches<CR>", "Search branches" }
	keys_git.s = { ":Telescope git_stash<CR>", "Search branches" }

	M.git_keys.l = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle Line blame" }
	M.git_keys.s = { ":Gitsigns stage_hunk<CR>", "Stage Hunk" }
	M.git_keys.S = { ":Gitsigns stage_buffer<CR>", "Stage Buffer" }
	M.git_keys.d = { ":Gitsigns toggle_deleted<CR>", "Toggle deleted lines" }
	M.git_keys.D = { ":Gitsigns diffthis<CR>", "Diff current buffer" }
	M.git_keys.h = { ":Gitsigns preview_hunk_inline<CR>", "Preview Hunk Inline" }
	M.git_keys.R = { ":Gitsigns reset_buffer<CR>", "Reset Buffer" }
	M.git_keys.r = { ":Gitsigns reset_hunk<CR>", "Reset Hunk" }
end

return M
