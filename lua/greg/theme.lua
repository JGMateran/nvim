vim.keymap.set('n', '<leader><Tab>', ':NvimTreeToggle<cr>', {})

require('lualine').setup({
  options = {
    theme = 'tokyonight'
  }
})

require('tokyonight').setup({
  style = 'night'
})

vim.cmd[[colorscheme tokyonight]]
