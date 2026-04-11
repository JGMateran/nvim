vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d", "biomejs" },
  typescript = { "eslint_d", "biomejs" },
  javascriptreact = { "eslint_d", "biomejs" },
  typescriptreact = { "eslint_d", "biomejs" },
}

local timer = vim.uv.new_timer()

local function do_lint()
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)
  if #names > 0 then
    lint.try_lint()
  end
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    if timer then
      timer:stop()
      timer:start(100, 0, vim.schedule_wrap(do_lint))
    end
  end,
})
