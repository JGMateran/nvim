vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
})

local lualine = require("lualine")

lualine.setup({
  options = {
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "diagnostics",
        symbols = {
          error = " ",
          warn = " ",
          hint = "󰌵 ",
          info = " ",
        },
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = " ",
          readonly = " ",
          unnamed = " ",
          newfile = " ",
        },
      },
    },
    lualine_z = { "location" },
  },
})

