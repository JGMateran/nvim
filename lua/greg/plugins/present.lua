vim.pack.add({
  "https://github.com/tjdevries/present.nvim",
})

require("present").setup({})

vim.keymap.set("n", "<leader>ps", "<cmd>PresentStart<cr>", { desc = "Present: Start" })
vim.keymap.set("n", "<leader>pe", "<cmd>PresentEnd<cr>", { desc = "Present: End" })
