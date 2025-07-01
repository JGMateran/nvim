return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
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
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
  },
}
