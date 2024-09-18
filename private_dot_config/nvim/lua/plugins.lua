return {
	-- iceberg
	{ "cocopon/iceberg.vim" },

	-- nvim-tree.lua
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
	},

	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		version = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "emoji" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},

	-- nvim-tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	{
		"stevearc/conform.nvim",
	},

	-- trouble.nvim
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- mini.nvim
	{
		"echasnovski/mini.nvim",
		version = "*",
		opts = {},
		config = function()
			vim.api.nvim_create_autocmd({ "InsertEnter" }, {
				pattern = "*",
				callback = function()
					require("mini.comment").setup({})
					require("mini.pairs").setup({})
					require("mini.surround").setup({})
				end,
			})
		end,
		once = true,
	},

	-- wakatime
	{ "wakatime/vim-wakatime", lazy = false },
}
