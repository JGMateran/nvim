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
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    }
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    }
  }
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lualine/lualine.nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    tag = 'nightly'
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
    'vim',
    'tsx',
    'javascript',
    'html',
    'css'
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

vim.opt.termguicolors = true

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
vim.opt.completeopt= "menu,menuone,noselect"

vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})

vim.cmd[[colorscheme tokyonight]]

require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
  ensure_installed = {
    'sumneko_lua',
    'tsserver',
    'gopls'
  }
})

local on_attach = function (client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = {
    noremap = true, 
    silent = true, 
    buffer = bufnr
  } 

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
end

local lsp_flags = {
  debounce_text_change = 150
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup_handlers {
  function (server_name)
    require('lspconfig')[server_name].setup({
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities
    })
  end
}

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  }, {
    { name = 'buffer' },
  })
})

require('gitsigns').setup()
require('lualine').setup()

require('nvim-tree').setup({
  git = {
    ignore = false
  }
})

vim.keymap.set('n', '<leader><Tab>', ':NvimTreeToggle<cr>', {})
