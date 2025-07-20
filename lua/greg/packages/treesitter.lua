vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-treesitter/playground",
})

require("nvim-treesitter.configs").setup({
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
  playground = {
    enable = true,
  },
  ensure_installed = {
    "vue",
    "astro",
    "bash",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "prisma",
    "regex",
    "tsx",
    "typescript",
    "vim",
    "python",
    "jsdoc",
    "php",
    "ron",
    "rust",
    "toml",
    "vimdoc",
    "sql",
    "http",

    "go",
    "gomod",
    "gosum",
    "gowork",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<M-space>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
  filename = {},
  pattern = {},
})
