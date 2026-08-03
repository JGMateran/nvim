vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "oxfmt", "oxlint", stop_after_first = false },
    typescript = { "oxfmt", "oxlint", stop_after_first = false },
    javascriptreact = { "oxfmt", "oxlint", stop_after_first = false },
    typescriptreact = { "oxfmt", "oxlint", stop_after_first = false },
    json = { "oxfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
