vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

local lualine = require("lualine")

local function lsp_status()
  if vim.version().minor >= 12 then
    return vim.ui.progress_status()
  end
  return ""
end

lualine.setup({
  options = {
    theme = "catppuccin",
    globalstatus = true,
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
  },
  sections = {
    lualine_a = { { "mode", icon = "" } },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", symbols = { added = "  ", modified = "  ", removed = "  " } },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 2,
        symbols = {
          modified = " ",
          readonly = " ",
          unnamed = " [No Name]",
          newfile = " ",
        },
      },
    },
    lualine_x = {
      { "diagnostics", symbols = { error = "", warn = "", info = "", hint = "󰌵  " } },
      { lsp_status, icon = "", show_name = true },
    },
    lualine_y = {
      { "filetype", icon_only = true },
      { "progress" },
    },
    lualine_z = { { "location" } },
  },
})
