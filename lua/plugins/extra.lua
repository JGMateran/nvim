return {
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Open undo interface" },
    },
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Toggle workspace diagnostics in Troubl" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Toggle document diagnostics in Trouble" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Toggle loclist in Trouble" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Toggle quickfix list in Trouble" },
      { "<leader>xR", "<cmd>TroubleToggle lsp_references<cr>", desc = "Toggle LSP references in Trouble" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
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
    "numToStr/Comment.nvim",
    opts = {
      pre_hook = function(...)
        local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

        if loaded and ts_comment then
          return ts_comment.create_pre_hook()(...)
        end
      end,
    },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
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
      },
    },
    init = function()
      local api = require("supermaven-nvim.api")

      api.use_free_version()
    end,
  },
}
