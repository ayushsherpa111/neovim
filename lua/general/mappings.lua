local M = {}

M.general_keys = {
    -- NOTE: Some mappings are assigned in the lspconfig `on_attach` function
    ["<Esc>"] = {":nohlsearch<CR>", "Exit search"},
    ["<C-s>"] = {":%s/\\v", "Replace", silent = false},
    ["<C-q>"] = {":bdelete<CR>", "Delete buffer"},
    -- Nvim tree
    ["<leader>l"] = {require'nvim-tree'.toggle, "Toggle file explorer"},
    -- Telescope and gitsigns
    ["/"] = {":lua require 'telescope.builtin'.live_grep {grep_open_files = true}<CR>", "Search text"},
    ["\\"] = {
        f = {":Telescope find_files<CR>", "Search file"},
        h = {":Telescope search_history<CR>", "Search history"},
        p = {":Telescope commands<CR>", "Search command"},
        b = {":Telescope buffers<CR>", "Search buffers"}
    },
    -- Compe
    ["<Tab>"] = {"v:lua.tab_complete()", "Next option", mode = "i", expr = true},
    ["<S-Tab>"] = {"v:lua.s_tab_complete()", "Previous option", mode = "i", expr = true},
    ["<CR>"] = {"compe#confirm('<CR>')", "Confirm selection", mode = "i", expr = true},
    -- Bufferline
    ["<A-l>"] = {":BufferLineCycleNext<CR>", "Next tab"},
    ["<A-h>"] = {":BufferLineCyclePrev<CR>", "Previous tab"},
    ["<C-l>"] = {":wincmd l<CR>", "Navigate right"},
    ["<C-h>"] = {":wincmd h<CR>", "Navigate left"},
    ["<C-k>"] = {":wincmd k<CR>", "Navigate up"},
    ["<C-j>"] = {":wincmd j<CR>", "Navigate down"}
}

M.visual_keys = {
    ["<C-s>"] = {":s/\\v", "Replace selection", mode = "v", silent = false}
}

M.saga_keys = {
    name = "Lsp",
    d = {"<cmd>lua require 'lspsaga.provider'.preview_definition()<CR>", "Preview definition"},
    r = {"<cmd>lua require 'lspsaga.rename'.rename()<CR>", "Rename definition"},
    k = {"<cmd>lua require 'lspsaga.hover'.render_hover_doc()<CR>", "Hover doc"},
    a = {"<cmd>lua require 'lspsaga.codeaction'.code_action()<CR>", "Code action"},
    e = {":TroubleToggle<CR>", "Open error summary"},
    q = {":Trouble quickfix<CR>", "Open quick fix summary"},
    s = {"<cmd>lua require 'lspsaga.provider'.lsp_finder()<CR>", "Lsp finder"},
    h = {"<cmd>lua require 'lspsaga.signaturehelp'.signature_help()<CR>", "Signature help"},
    ["]"] = {"<cmd>lua require 'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", "Go to next diagnostic"},
    ["["] = {"<cmd>lua require 'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", "Go to previous diagnostic"},
    ["/"] = {"<cmd>lua require 'lspsaga.floaterm'.open_float_terminal()<CR>", "Open terminal"}
}

if os.execute("git status") == 0 then
    local keys_git = M.general_keys["\\"]
    keys_git.c = {":Telescope git_commits<CR>", "Search commit history"}
    keys_git.b = {":Telescope git_branches<CR>", "Search branches"}
end

return M
