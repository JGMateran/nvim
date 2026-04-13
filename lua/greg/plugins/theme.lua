vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  },
})

local catppuccin = require("catppuccin")

--- @diagnostic disable-next-line: missing-fields
catppuccin.setup({
  integrations = {
    blink_cmp = true,
    snacks = true,
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
  },
  custom_highlights = function(colors)
    return {
      Pmenu = { bg = colors.base, fg = colors.overlay2 },
      PmenuSel = { bg = colors.surface0, style = { "bold" } },

      NormalFloat = { fg = colors.text, bg = colors.base },
      FloatBorder = { fg = colors.blue, bg = colors.base },
      FloatTitle = { fg = colors.subtext0, bg = colors.base },

      BlinkCmpMenu = { bg = colors.base },
      BlinkCmpMenuBorder = { fg = colors.blue, bg = colors.base },
      BlinkCmpDoc = { bg = colors.base },
      BlinkCmpDocBorder = { fg = colors.blue, bg = colors.base },

      SnacksIndent = { fg = colors.overlay0 },
      SnacksIndentScope = { fg = colors.rosewater },
    }
  end,
})

vim.cmd.colorscheme("catppuccin")
