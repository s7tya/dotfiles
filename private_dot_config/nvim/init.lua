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
    }
	}
})

-- plugins:nvim-tree
local function open_nvim_tree()
  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- theme
vim.cmd "colorscheme iceberg"
