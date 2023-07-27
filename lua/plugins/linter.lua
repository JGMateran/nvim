return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local format_on_save = function(bufnr)
      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.stylua.with({
          extra_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
          },
        }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              format_on_save(bufnr)
            end,
          })
        end
      end,
    })
  end,
}
