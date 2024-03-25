return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspLinting", { clear = true })

      require("lint").linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = augroup,
        pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
