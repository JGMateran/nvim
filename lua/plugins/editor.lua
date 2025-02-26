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
        diagnostics = {
          symbols = {
            error = "",
            warn = "",
            hint = "󰌵",
            info = " ",
          },
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
      { "<leader><tab>", "<cmd>Neotree toggle<cr>", desc = "Open Neotree" },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = {
          "copilot-chat",
          "markdown",
          "markdown.mdx",
          "git",
          "undotree",
          "fugitive",
        },
      },
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
    init = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
        callback = function()
          if vim.bo.filetype == "" then
            vim.b.miniindentscope_disable = true
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "trouble",
          "lazy",
          "mason",
          "markdown",
          "markdown.mdx",
          "git",
          "snacks_terminal",
          "copilot-chat",
          "git",
          "snacks_dashboard",
          "snacks_notif",
          "Avante",
          "undotree",
          "fugitive",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      win_options = {
        winblend = 0,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        -- theme = "tokyonight",
        icons_enabled = false,
        -- component_separators = "│",
        component_separators = "",
        section_separators = "",
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
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact",
      },
      styles = {
        scratch = {
          width = 80,
          height = 15,
        },
        notification = {
          wo = {
            wrap = true,
            winblend = 0,
          },
        },
      },
    },
    keys = {
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
    },
  },
}
