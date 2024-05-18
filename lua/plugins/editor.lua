return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- enable_git_status = false,
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          hide_gitignored = false,
          hide_dotfiles = false,
        },
      },
      default_component_configs = {
        name = {
          -- use_git_status_colors = false,
        },
        modified = {
          symbol = "",
        },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
            renamed = "",
            untracked = "",
            ignored = "◌",
            unstaged = "",
            staged = "S",
            conflict = "",
          },
        },
      },
    },
    keys = {
      { "<leader><tab>", "<cmd>Neotree toggle<cr>" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        enabled = false,
      },
      -- char = "┊",
      -- show_trailing_blankline_indent = false,
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "┊",
    },
  },
  {
    "stevearc/dressing.nvim",
    enabled = false,
    opts = {
      win_options = {
        winblend = 0,
      },
    },
    {
      "folke/noice.nvim",
      enabled = true,
      event = "VeryLazy",
      opts = {
        notify = {
          enabled = false,
        },
        lsp = {
          progress = {
            enabled = false,
          },
        },
      },
      config = function(_, opts)
        require("noice").setup(opts)

        ---@diagnostic disable: missing-fields
        require("notify").setup({
          background_colour = "#000000",
        })
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    },
  },
}
