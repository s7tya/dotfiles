-- basic settings
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"


vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

vim.opt.cursorline = true
vim.opt.number = true

vim.opt.helplang = "ja"

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.list = true
vim.opt.listchars = { tab = ">>", trail = "-", nbsp = "+" }

-- nvim-tree.lua settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
    		"https://github.com/folke/lazy.nvim.git",
    		"--branch=stable", -- latest stable release
    		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
	spec = {
    -- iceberg
    {
      "cocopon/iceberg.vim",
    },

    -- nvim-tree.lua
    { 
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {},
    },

    -- nvim-lspconfig
    {
      "neovim/nvim-lspconfig"
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
      once = true
    },

    -- ddc.vim
    {
      "Shougo/ddc.vim",
      dependencies = { "vim-denops/denops.vim" },
    },
    {
      "Shougo/ddc-around",
      dependencies = { "Shougo/ddc.vim" },
    },
    {
      "LumaKernel/ddc-file",
      dependencies = { "Shougo/ddc.vim" },
    },
    {
      "Shougo/ddc-filter-matcher_head",
      dependencies = { "Shougo/ddc.vim" },
    },
    {
      "Shougo/ddc-sorter_rank",
      dependencies = { "Shougo/ddc.vim" },
    },
    {
      "Shougo/ddc-converter_remove_overlap",
      dependencies = { "Shougo/ddc.vim" },
    },

    -- wakatime
    { 'wakatime/vim-wakatime', lazy = false },

    }
})

-- plugins:nvim-lspconfig
local lspconfig = require('lspconfig')

-- Setup language servers.
-- lspconfig.rust_analyzer.setup {
--   -- Server-specific settings. See `:help lspconfig-setup`
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- }

local on_attach = function(client)
    require'completion'.on_attach(client)
end

lspconfig.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- plugins:nvim-tree
local function open_nvim_tree()
  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- theme
vim.cmd "colorscheme iceberg"
