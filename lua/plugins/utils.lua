return {
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle },
    },
  },
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
  {},
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
}
