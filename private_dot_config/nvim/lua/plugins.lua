return {
	-- iceberg
	{ "cocopon/iceberg.vim" },

	-- lspconfig
	{ "neovim/nvim-lspconfig" },

	-- nvim-tree.lua
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle Nvim-tree" },
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true
		end,
		config = function()
			require("nvim-tree").setup({
				actions = {
					open_file = { quit_on_open = true },
				},
			})
		end,
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
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt", lsp_format = "fallback" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},

	-- trouble.nvim
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- mini.nvim
	{
		"echasnovski/mini.nvim",
		version = "*",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd({ "InsertEnter" }, {
				pattern = "*",
				callback = function()
					require("mini.comment").setup({})
					require("mini.pairs").setup({})
					require("mini.surround").setup({})
				end,
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					local map = require("mini.map")
					map.setup({
						integrations = {
							map.gen_integration.builtin_search(),
							map.gen_integration.diagnostic({
								error = "DiagnosticFloatingError",
								warn = "DiagnosticFloatingWarn",
								info = "DiagnosticFloatingInfo",
								hint = "DiagnosticFloatingHint",
							}),
						},
					})
					map.open()
				end,
			})
		end,
		once = true,
	},

	-- wakatime
	{ "wakatime/vim-wakatime", lazy = false },

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope: find files",
			},

			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Telescope: live grep",
			},

			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Telescope: buffers",
			},

			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Telescope: help tags",
			},
		},
	},
}
