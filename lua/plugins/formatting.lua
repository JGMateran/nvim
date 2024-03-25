return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "eslint_d", "eslint" } },
        typescript = { { "eslint_d", "eslint" } },
        javascriptreact = { { "eslint_d", "eslint" } },
        typescriptreact = { { "eslint_d", "eslint" } },
      },
    },
  },
}
