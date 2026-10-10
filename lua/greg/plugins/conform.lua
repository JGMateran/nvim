vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

conform.setup({
  formatters = {
    biome = { require_cwd = true },
    prettierd = { require_cwd = true },
    oxfmt = {
      command = "oxfmt",
      args = { "--stdin-filepath", "$FILENAME" },
      stdin = true,
      cwd = require("conform.util").root_file({
        ".oxfmtrc.json",
        ".oxfmtrc.jsonc",
        "oxfmt.json",
      }),
      require_cwd = true,
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
    typescript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
    javascriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
    typescriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
    json = { "oxfmt", "biome", "prettierd", stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
