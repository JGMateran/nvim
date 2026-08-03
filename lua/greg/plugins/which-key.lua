vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

require("which-key").setup({})

require("which-key").add({
  { "<leader>f", group = " Find" },
  { "<leader>g", group = " Git" },
  { "<leader>x", group = " Trouble" },
  { "<leader>c", group = " Code" },
  { "<leader>h", group = " Hunk (Gitsigns)" },
  { "<leader>b", group = " Buffer" },
  { "<leader>u", group = " Undo / UI" },
  { "<leader>p", group = " Present / Yank" },
  { "<leader>t", group = " Toggle" },
})

vim.o.timeout = true
vim.o.timeoutlen = 1000
