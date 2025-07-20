vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local snacks = require("snacks")

snacks.setup({
  indent = {
    enable = true,
    indent = {
      char = "┊",
    },
    scope = {
      enable = true,
      char = "┊",
    },
  },
  statuscolumn = {
    enable = true,
  },
})
