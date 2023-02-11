local neogit = require('neogit')

neogit.setup({
  integrations = {
    diffview = true
  }
})

vim.keymap.set('n', '<leader>gg', ':Neogit<cr>', { noremap = true })
vim.keymap.set('n', '<leader>gc', ':Neogit commit<cr>', { noremap = true })
