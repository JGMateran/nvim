return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- javascript = { "biome-check", "prettierd", "eslint_d", "eslint", stop_after_first = true },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
    },
    config = function(_, opts)
      local conform = require("conform")

      conform.setup(opts)

      local group = vim.api.nvim_create_augroup("Conform", { clear = true })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.lua", "*.mjs" },
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
