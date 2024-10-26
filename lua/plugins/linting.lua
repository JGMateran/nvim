local function root_file(files, dirname)
  local found = vim.fs.find(files, { upward = true, path = dirname })[1]

  if found then
    return true
  end

  return false
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d", "biomejs" },
        typescript = { "eslint_d", "biomejs" },
        javascriptreact = { "eslint_d", "biomejs" },
        typescriptreact = { "eslint_d", "biomejs" },
      },
      linters = {
        eslint_d = {
          condition = function(ctx)
            return root_file({ ".eslintrc.js", ".eslintrc.json" }, ctx.filename)
          end,
        },
        biomejs = {
          condition = function(ctx)
            return root_file({ "biome.jsonc", "biome.json" }, ctx.filename)
          end,
        },
      },
    },
    config = function(_, opts)
      local M = {}
      local lint = require("lint")

      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        local ctx = {}

        ctx.filename = vim.api.nvim_buf_get_name(0)
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

        local filtered_names = vim.tbl_filter(function(name)
          local linter = opts.linters[name]
          if not linter then
            print("Linter not found: " .. name)

            return false
          end

          return linter.condition(ctx)
        end, names)

        lint.try_lint(filtered_names)
      end

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("LspLinting", { clear = true }),
        pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
        callback = M.debounce(500, M.lint),
      })
    end,
  },
}
