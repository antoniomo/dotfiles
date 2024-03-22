return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.conform")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			git = { enable = true },
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"bash-language-server",
				"json-lsp",
				"goimports",
				"gopls",
				"mdformat",
				"pyright",
				"ruff",
				"ruff-lsp",
				"rust-analyzer",
				"shfmt",
				"vale",
				"vale-ls",
				"yaml-language-server",
				"yamlfmt",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			local wk = require("which-key")
			wk.register({
				["<leader>md"] = { ":MarkdownPreviewToggle<CR>", "Markdown Preview" },
			})
		end,
	},
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		init = function()
			local wk = require("which-key")
			wk.register({
				["<leader>sc"] = { ":Silicon<CR>", "Snapshot Code" },
			}, { mode = "v" })
		end,
		config = function()
			require("silicon").setup({
				-- Configuration here, or leave empty to use defaults
				font = "Fira Code Nerd Font=34;Noto Color Emoji=34",
			})
		end,
	},
	-- {
	--   "mrcjkb/rustaceanvim",
	--   ft = "rust",
	--   dependencies = "neovim/nvim-lspconfig",
	--   version = "^4",
	--   opts = function()
	--     return require "configs.rustaceanvim"
	--   end,
	--   config = function(_, opts)
	--     require("rustaceanvim").setup(opts)
	--   end
	-- },
}
