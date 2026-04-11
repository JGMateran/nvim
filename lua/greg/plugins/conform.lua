vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "oxfmt", "prettierd", "biome-check", stop_after_first = true },
    typescript = { "oxfmt", "prettierd", "biome-check", stop_after_first = true },
    javascriptreact = { "oxfmt", "prettier", "biome-check", stop_after_first = true },
    typescriptreact = { "oxfmt", "prettierd", "biome-check", stop_after_first = true },
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
