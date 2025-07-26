vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint",
})

local opts = {
  linters_by_ft = {
    javascript = { "biomejs", "eslint" },
    typescript = { "biomejs", "eslint" },
    javascriptreact = { "biomejs", "eslint_d" },
    typescriptreact = { "eslint_d" },
  },
  linters = {
    eslint_d = {
      condition = function(ctx)
        local files = vim.fs.find(
          { ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json", "eslint.config.js" },
          { upward = true, path = ctx.dirname }
        )

        local found = files[1]

        if found then
          return true
        end

        return false
      end,
    },
    biomejs = {
      condition = function(ctx)
        local files = vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = ctx.dirname })
        local found = files[1]

        if found then
          return true
        end

        return false
      end,
    },
  },
}

local nvim_lint = require("lint")

nvim_lint.linters_by_ft = opts.linters_by_ft

local function lint()
  local names = nvim_lint._resolve_linter_by_ft(vim.bo.filetype)

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

  nvim_lint.try_lint(filtered_names)
end

local lint_group = vim.api.nvim_create_augroup("LspLinting", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = lint_group,
  callback = function()
    lint()
  end,
})
