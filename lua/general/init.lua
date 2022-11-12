local utils = require "general.helpers"
local keys = require "general.mappings"

local HOME = os.getenv("HOME")

utils.set_opts {
    mouse = "a",
    ts = 4,
    sw = 4,
    expandtab = true,
    clipboard = "unnamedplus",
    inccommand = "split",
    number = true,
    relativenumber = true,
    termguicolors = true,
    ignorecase = true,
    smartcase = true,
    undofile = true,
    undodir = HOME .. "/.cache/nvim/undo",
    backupdir = HOME .. "/.cache/nvim/backups",
    completeopt = "menuone,noselect",
    updatetime = 500,
    showmode = false,
    timeoutlen = 500,
    shortmess = "c",
    wrap = false,
    showmatch = true
}

vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = {"terraform"},
        callback = function ()
            vim.opt.ts = 2
            vim.opt.sw = 2
        end
    }
)

-- Hack for syntax highlighting in Helm
vim.api.nvim_create_autocmd(
    {"BufNewFile", "BufRead"},
    {
        pattern = {"*.gotmpl", "*.tpl", "*.tmpl", "*/templates/*.yaml", "*/templates/*.yml"},
        callback = function ()
            vim.opt_local.filetype = "gotmpl"
        end
    }
)

local which_key = require "which-key"

which_key.register(keys.general_keys)
which_key.register(keys.visual_keys)
