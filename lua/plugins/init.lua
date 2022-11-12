local function update_mkdp()
    vim.call [[mkdp#util#install]]
end

require "paq" {
    "savq/paq-nvim",
    --Dependencies
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    -- Lsp
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
    "hrsh7th/nvim-compe",
    "tami5/lspsaga.nvim",
    -- Telescope
    "nvim-telescope/telescope.nvim",
    -- Helpers
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "folke/which-key.nvim",
    "kyazdani42/nvim-tree.lua",
    "ahmedkhalf/lsp-rooter.nvim",
    "andweeb/presence.nvim",
    -- Looks
    {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
    "lukas-reineke/indent-blankline.nvim",
    "folke/tokyonight.nvim",
    { "glepnir/galaxyline.nvim", branch= "main" },
    "akinsho/nvim-bufferline.lua",
    "glepnir/dashboard-nvim",
    "lewis6991/gitsigns.nvim",
    "onsails/lspkind-nvim", -- incomplete
    "folke/trouble.nvim",
    -- Language specific
    {"iamcco/markdown-preview.nvim", run = update_mkdp},
    "mhartington/formatter.nvim"
}

require "plugins.misc"
