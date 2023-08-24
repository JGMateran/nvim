return {
  "mhartington/formatter.nvim",
  enabled = false,
  config = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

    require("formatter").setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        javascript = {
          require("formatter.filetypes.javascript").eslint_d,
        },
        typescript = {
          require("formatter.filetypes.typescript").eslint_d,
        },
        javascriptreact = {
          require("formatter.filetypes.javascriptreact").eslint_d,
        },
        typescriptreact = {
          require("formatter.filetypes.typescriptreact").eslint_d,
        },
        lua = {
          require("formatter.filetypes.lua").stylua,
        },
      },
    })

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.lua" },
      group = augroup,
      command = "FormatWrite",
    })
  end,
}
