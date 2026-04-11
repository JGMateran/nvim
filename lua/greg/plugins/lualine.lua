vim.pack.add({
  {
    src = "https://github.com/nvim-lualine/lualine.nvim",
  },
})

require("lualine").setup({})

-- vim.pack.add({
--   "https://github.com/nvim-tree/nvim-web-devicons",
--   "https://github.com/nvim-lualine/lualine.nvim",
-- })
--
-- local lualine = require("lualine")
--
-- lualine.setup({
--   options = {
--     globalstatus = true,
--   },
--   sections = {
--     lualine_a = { "mode" },
--     lualine_b = {
--       "branch",
--       {
--         "diagnostics",
--         symbols = {
--           error = " ",
--           warn = " ",
--           hint = "󰌵 ",
--           info = " ",
--         },
--       },
--     },
--     lualine_c = {
--       function()
--         return " "
--       end,
--       color = function()
--         local status = require("sidekick.status").get()
--
--         if status then
--           return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
--         end
--       end,
--       cond = function()
--         local status = require("sidekick.status")
--
--         return status.get() ~= nil
--       end,
--     },
--     lualine_x = {},
--     lualine_y = {
--       {
--         "filename",
--         path = 1,
--         symbols = {
--           modified = " ",
--           readonly = " ",
--           unnamed = " ",
--           newfile = " ",
--         },
--       },
--     },
--     lualine_z = { "location" },
--   },
-- })
