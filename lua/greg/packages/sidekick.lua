vim.pack.add({
  {
    src = "https://github.com/folke/sidekick.nvim",
  },
})

local sidekick = require("sidekick")

sidekick.setup({
  cli = {
    win = {
      layout = "right",
      split = {
        width = 50,
        height = 20,
      },
    },
  },
})

vim.keymap.set("n", "<leader>aa", function()
  require("sidekick.cli").toggle({ name = "gemini", focus = true })
end, { desc = "Toggle sidekick" })

vim.keymap.set("n", "<leader>ac", function()
  require("sidekick.cli").select_prompt()
end, { desc = "Select prompt" })
