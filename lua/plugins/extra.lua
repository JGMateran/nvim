return {
  {
    "tjdevries/present.nvim",
  },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      {
        "<leader>k",
        '<cmd>lua require("kulala").run()<cr>',
        desc = "Send the request",
        ft = "http",
      },
    },
    opts = {
      split_direction = "horizontal",
      icons = {
        inlay = {
          loading = " ",
          done = " ",
          error = " ",
        },
      },
    },
    init = function()
      vim.filetype.add({
        extension = {
          ["http"] = "http",
        },
      })
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Open undo interface" },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    enabled = false,
    "karb94/neoscroll.nvim",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "windwp/nvim-autopairs",
    opts = {},
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "laytan/cloak.nvim",
    opts = {
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      cloak_length = nil,
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
        },
      },
    },
  },
  {
    "tpope/vim-sleuth",
  },
  {
    "bennypowers/splitjoin.nvim",
    lazy = true,
    keys = {
      {
        "gj",
        function()
          require("splitjoin").join()
        end,
        desc = "Join the object under cursor",
      },
      {
        "g,",
        function()
          require("splitjoin").split()
        end,
        desc = "Split the object under cursor",
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    enabled = false,
    config = function()
      require("illuminate").configure({
        filetypes_denylist = {
          "DressingInput",
          "TelescopePrompt",
          "fugitive",
          "gitcommit",
          "lazy",
          "mason",
          "neo-tree-popup",
        },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
    opts = {},
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      {
        "<leader>p",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open yank history",
      },
    },
    opts = {
      highlight = {
        timer = 150,
      },
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      ignore_filetypes = {
        ["neo-tree-popup"] = true,
        ["TelescopePrompt"] = true,
        ["DressingInput"] = true,
        ["oil"] = true,
      },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {
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
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "-",
        "<cmd>Oil --float<cr>",
        desc = "Open Oil",
      },
    },
  },
  {
    "TobinPalmer/rayso.nvim",
    cmd = { "Rayso" },
    opts = {
      open_cmd = "firefox",
      options = {
        background = true,
        dark_mode = true,
        padding = 32,
        theme = "tailwind",
      },
    },
  },
}
