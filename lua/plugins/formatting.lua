return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "biome-check", "eslint_d", "eslint" } },
        typescript = { { "biome-check", "eslint_d", "eslint" } },
        javascriptreact = { { "biome-check", "eslint_d", "eslint" } },
        typescriptreact = { { "biome-check", "eslint_d", "eslint" } },
      },
    },
    config = function(_, opts)
      local conform = require("conform")

      conform.setup(opts)

      local group = vim.api.nvim_create_augroup("Conform", { clear = true })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.lua" },
        group = group,
        callback = function(args)
          conform.format({
            bufnr = args.buf,
          })
        end,
      })
    end,
  },
}
