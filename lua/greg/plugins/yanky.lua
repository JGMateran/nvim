vim.pack.add({
  "https://github.com/gbprod/yanky.nvim",
})

require("yanky").setup({
  highlight = {
    timer = 150,
  },
})

vim.keymap.set("n", "<leader>p", function()
  Snacks.picker.registers()
end, { desc = "Open yank history (Snacks)" })
