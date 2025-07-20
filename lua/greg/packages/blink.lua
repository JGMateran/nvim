vim.pack.add({
  "https://github.com/saghen/blink.cmp",
})

local blink = require("blink-cmp")

blink.setup({
  keymap = {
    preset = "enter",
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    menu = {
      scrollbar = false,
      border = "rounded",
      draw = {
        treesitter = {
          "lsp",
        },
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon" },
        },
      },
    },
    documentation = {
      auto_show = false,
      window = {
        border = "rounded",
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#00ff00" })
