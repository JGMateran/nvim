vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

require("oil").setup({
  win_options = {
    number = false,
    relativenumber = false,
    cursorline = true,
  },
  float = {
    preview_split = "right",
    padding = 2,
    max_width = 70,
    max_height = 70,
  },
})

vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open Oil" })
