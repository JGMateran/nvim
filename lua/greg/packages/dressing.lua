vim.pack.add({
  "https://github.com/stevearc/dressing.nvim",
})

require("dressing").setup({
  win_options = {
    winblend = 0,
  },
})
