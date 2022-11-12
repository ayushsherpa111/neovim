require "lsp-rooter".setup {}
require "Comment".setup()
require "nvim-autopairs".setup {}
require "presence":setup {
    main_image = "file"
}

require "nvim-tree".setup {
    auto_close = true,
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
        ignore_list = {}
    },
    system_open = {
        cmd = nil,
        args = {}
    },
    renderer = {
        highlight_git = true,
        indent_markers = {
            enable = true
        }
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "▲",
            error = "🗙"
        }
    },
    filters = {
          dotfiles = true,
          custom = {}
    }
}

local get_name = vim.api.nvim_buf_get_name

require "formatter".setup {
    logging = false,
    filetype = {
        python = {
            function()
                return {
                    exe = "python",
                    args = {"-m", "black", get_name(0)},
                    stdin = false
                }
            end
        },
        go = {
            function()
                return {
                    exe = "gofmt",
                    args = {"-w", get_name(0)},
                    stdin = false
                }
            end
        },
        lua = {
            function()
                return {
                    exe = "luafmt",
                    args = {"--indent-count", 4, "--stdin"},
                    stdin = true
                }
            end
        },
        yaml = {
            function()
                return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.fn.fnameescape(get_name(0)), "--single-quote"},
                    stdin = true
                }
            end
        },
        json = {
            function()
                return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.fn.fnameescape(get_name(0))},
                    stdin = true
                }
            end
        },
        markdown = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.fnameescape(get_name(0)),
                        "--prose-wrap always"
                    },
                    stdin = true
                }
            end
        }
    }
}

vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = {"*"},
        callback = function ()
            vim.cmd [[FormatWrite]]
        end
    }
)

-- jump to last cursor position
vim.api.nvim_create_autocmd(
    "BufRead",
    {
        pattern = {"*"},
        callback = function ()
            vim.cmd [[
                autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
            ]]
        end
    }
)
