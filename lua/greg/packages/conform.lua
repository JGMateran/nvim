vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "biome-check", "prettierd", "eslint_d", "eslint", stop_after_first = true },
    typescript = { "biome-check", "prettierd", stop_after_first = true },
    javascriptreact = { "biome-check", stop_after_first = true },
    typescriptreact = { "biome-check", stop_after_first = true },
  },
})

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
