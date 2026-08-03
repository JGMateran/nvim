vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

require("nvim-treesitter").setup({})

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["ab"] = "@block.outer",
      ["ib"] = "@block.inner",
      ["aa"] = "@parameter.inner",
    },
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
  },
})

local parsers = {
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
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)

    if lang then
      pcall(vim.treesitter.start, args.buf, lang)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
  filename = {},
  pattern = {},
})
