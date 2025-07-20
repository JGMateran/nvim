vim.pack.add({
  "https://github.com/yetone/avante.nvim",
  "https://github.com/stevearc/dressing.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/HakonHarnes/img-clip.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("avante").setup({
  provider = "gemini",
  hints = {
    enabled = false,
  },
  file_selector = {
    provider = "snacks",
  },
  windows = {
    sidebar_header = {
      enabled = true,
      align = "center",
      rounded = false,
    },
    input = {
      prefix = " ",
      height = 1,
    },
    edit = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      start_insert = true,
    },
    ask = {
      floating = true,
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      start_insert = true,
      focus_on_apply = "ours",
    },
    position = "right",
  },
})
