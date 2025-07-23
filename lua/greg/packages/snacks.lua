vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local snacks = require("snacks")

snacks.setup({
  input = {},
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
  statuscolumn = {},
})
