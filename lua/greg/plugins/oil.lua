vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
  default_file_explorer = true,
  columns = {
    "icon",
  },
  keymaps = {
    ["<C-p>"] = "actions.preview",
    ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
    ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["g."] = { "actions.toggle_hidden", mode = "n" },
  },
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    concealcursor = "nvic",
    conceallevel = 3,
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = false,
    is_hidden_file = function(name)
      return vim.startswith(name, ".") or name == "node_modules"
    end,
    is_always_hidden_file = function(name)
      return name == ".."
    end,
  },
  float = {
    padding = 2,
    max_width = 0.8,
    max_height = 0.8,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
})

vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open parent directory in Oil" })
