vim.pack.add({
  "https://github.com/supermaven-inc/supermaven-nvim",
})

local supermaven = require("supermaven-nvim")

supermaven.setup({
  ignore_filetypes = {
    ["neo-tree-popup"] = true,
    ["snacks_picker_input"] = true,
    ["snacks_input"] = true,
    ["DressingInput"] = true,
    ["oil"] = true,
  },
})
