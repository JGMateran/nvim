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
  },
  autotag = {
    enable = true
  }
})
