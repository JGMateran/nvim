vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

require("nvim-treesitter").setup({})

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
