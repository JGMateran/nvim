vim.pack.add({
  "https://github.com/gbprod/yanky.nvim",
})

require("yanky").setup({
  highlight = {
    timer = 150,
  },
  textobj = {
    enabled = true,
  },
})

-- Put with Yanky (enables history cycling)
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put after" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put before" })
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put after cursor move" })
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put before cursor move" })

-- Cycle yank history after putting
vim.keymap.set("n", "<C-p>", "<Plug>(YankyPreviousEntry)", { desc = "Cycle to previous yank" })
vim.keymap.set("n", "<C-n>", "<Plug>(YankyNextEntry)", { desc = "Cycle to next yank" })

vim.keymap.set("n", "<leader>p", function()
  Snacks.picker.registers()
end, { desc = "Open yank history (Snacks)" })
