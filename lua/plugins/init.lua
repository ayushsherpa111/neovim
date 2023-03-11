local function update_mkdp()
	vim.call([[mkdp#util#install]])
end

require("paq")({
	"savq/paq-nvim",
	--Dependencies
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"kyazdani42/nvim-web-devicons",
	-- Lsp
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"tami5/lspsaga.nvim",
	"dcampos/nvim-snippy",
	"dcampos/cmp-snippy",
	-- debugger
	"mfussenegger/nvim-dap",
	"jayp0521/mason-nvim-dap.nvim",
	-- Telescope
	"nvim-telescope/telescope.nvim",
	-- Helpers
	"numToStr/Comment.nvim",
	"windwp/nvim-autopairs",
	"folke/which-key.nvim",
	"kyazdani42/nvim-tree.lua",
	"ahmedkhalf/lsp-rooter.nvim",
	"andweeb/presence.nvim",
	"leoluz/nvim-dap-go",
	-- Looks
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"lukas-reineke/indent-blankline.nvim",
	"folke/tokyonight.nvim",
    'tiagovla/tokyodark.nvim',
	"SmiteshP/nvim-navic",
	{ "glepnir/galaxyline.nvim", branch = "main" },
	"akinsho/nvim-bufferline.lua",
	"lewis6991/gitsigns.nvim",
	"onsails/lspkind-nvim", -- incomplete
	"folke/trouble.nvim",
	"numToStr/Navigator.nvim",
	-- Language specific
	{ "iamcco/markdown-preview.nvim", run = update_mkdp },
	"mhartington/formatter.nvim",
})

require("plugins.misc")
