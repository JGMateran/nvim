local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
	vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
	use 'folke/tokyonight.nvim'
	use {
		'nvim-telescope/telescope.nvim', 
		branch = '0.1.x', 
		requires = { 
			'nvim-lua/plenary.nvim'
		} 
	}
  use { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    run = 'make',
    cond = vim.fn.executable 'make' == 1 
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))
    end
  }
end)

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      }
    }
  }
}) 

pcall(require('telescope').load_extension, 'fzf')

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'cpp',
    'go',
    'lua',
    'typescript',
    'vim'
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true,
    disable = {
      'python'
    }
  }
})

vim.wo.number = true
vim.o.mouse = 'a'
vim.o.ondofile = true
vim.o.ignorecase = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.wrap = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.smartindent = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.o.clipboard = 'unnamedplus'
vim.opt.cursorline = true

vim.o.scrolloff = 8

vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})

vim.cmd[[colorscheme tokyonight]]
