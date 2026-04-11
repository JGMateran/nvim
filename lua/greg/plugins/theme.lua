vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  },
})

local catppuccin = require("catppuccin")

catppuccin.setup({
  custom_highlights = function(colors)
    return {
      BlinkCmpMenu = { bg = colors.base },
      BlinkCmpMenuBorder = { fg = colors.blue },
      BlinkCmpDocBorder = { fg = colors.blue },
      BlinkCmpMenuSelection = { bg = colors.surface0 },
      BlinkCmpLabel = { fg = colors.text },
      BlinkCmpLabelMatch = { fg = colors.text },
      SnacksIndent = { fg = colors.overlay0 },
      SnacksIndentScope = { fg = colors.rosewater },
    }
  end,
})

vim.cmd.colorscheme("catppuccin")
