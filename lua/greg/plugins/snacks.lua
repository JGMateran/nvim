vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local snacks = require("snacks")

snacks.setup({
  input = { enabled = true },
  notifier = {},
  quickfile = { enabled = true },
  scope = { enabled = true },
  picker = {
    ui_select = true,
    layout = {
      backdrop = false,
    },
    win = {
      input = { backdrop = false },
      list = { backdrop = false },
      preview = { backdrop = false },
    },
    icons = {
      files = {
        enabled = true,
        dir = " ",
        file = " ",
      },
      git = {
        added = " ",
        modified = " ",
        deleted = " ",
        ignored = "◌ ",
        staged = "S ",
        renamed = " ",
        untracked = " ",
        unmerged = " ",
      },
      diagnostics = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      },
      kinds = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
        Supermaven = " ",
      },
    },
    sources = {
      explorer = {
        auto_close = false,
        follow_file = true,
        hidden = true,
        ignored = true,
        layout = {
          layout = {
            position = "left",
            width = 30,
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = false,
              ["q"] = false,
            },
          },
          list = {
            keys = {
              ["<Esc>"] = false,
              ["q"] = false,
            },
          },
        },
      },
    },
  },
  styles = {
    float = {
      backdrop = false,
    },
  },
  explorer = {},
  terminal = {},
  zen = { enabled = true },
  bigfile = { enabled = true },
  lazygit = { enabled = true },
  gitbrowse = { enabled = true },
  rename = { enabled = true },
  dim = { enabled = true },
  indent = {
    enable = true,
    indent = {
      char = "┊",
    },
    scope = {
      enable = true,
      char = "┊",
    },
  },
  statuscolumn = {},
})

snacks.input.enable()
vim.ui.select = snacks.picker.select

-- SNACKS MAPPINGS
local map = vim.keymap.set

-- Explorer
map("n", "<leader><tab>", function()
  snacks.explorer()
end, { desc = "Toggle Snacks Explorer" })

-- Finders (Picker)
map("n", "<leader>ff", function()
  snacks.picker.files()
end, { desc = "Snacks: Find files" })
map("n", "<leader>fb", function()
  snacks.picker.buffers()
end, { desc = "Snacks: Find buffers" })
map("n", "<leader>fg", function()
  snacks.picker.grep()
end, { desc = "Snacks: Global grep" })
map("n", "<leader>fw", function()
  snacks.picker.grep_word()
end, { desc = "Snacks: Grep word under cursor" })
map("n", "<leader>fr", function()
  snacks.picker.recent()
end, { desc = "Snacks: Recent files" })
map("n", "<leader>fR", function()
  snacks.picker.resume()
end, { desc = "Snacks: Resume last picker" })
map("n", "<leader>fh", function()
  snacks.picker.help()
end, { desc = "Snacks: Help tags" })
map("n", "<leader>fk", function()
  snacks.picker.keymaps()
end, { desc = "Snacks: Keymaps" })
map("n", "<leader>fu", function()
  snacks.picker.undo()
end, { desc = "Snacks: Undo tree" })
map("n", "<leader>fd", function()
  snacks.picker.diagnostics()
end, { desc = "Snacks: Diagnostics (Workspace)" })
map("n", "<leader>fD", function()
  snacks.picker.diagnostics_buffer()
end, { desc = "Snacks: Diagnostics (Buffer)" })
map("n", "<leader>/", function()
  snacks.picker.lines()
end, { desc = "Snacks: Search lines in buffer" })

-- Git
map("n", "<leader>ge", function()
  snacks.picker.git_status()
end, { desc = "Git Explorer (Snacks)" })
map("n", "<leader>gl", function()
  snacks.picker.git_log()
end, { desc = "Git Log (Snacks)" })
map("n", "<leader>gd", function()
  snacks.picker.git_diff()
end, { desc = "Git Diff (Snacks)" })
map("n", "<leader>gp", function()
  snacks.picker.gh_pr()
end, { desc = "GitHub PRs (open)" })
map("n", "<leader>gP", function()
  snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub PRs (all)" })
map("n", "<leader>gi", function()
  snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })
map("n", "<leader>ga", function()
  snacks.picker.gh_actions()
end, { desc = "GitHub PR Actions (current)" })
map({ "n", "v" }, "<leader>gB", function()
  snacks.gitbrowse()
end, { desc = "Git Browse (Open in GitHub)" })
map("n", "<leader>gz", function()
  snacks.lazygit()
end, { desc = "LazyGit (Snacks)" })

-- Tags (ctags)
map("n", "<leader>ft", function()
  snacks.picker.tags()
end, { desc = "Snacks: Tags (ctags)" })

-- Refactor / Files
map("n", "<leader>cR", function()
  snacks.rename.rename_file()
end, { desc = "Rename file (LSP sync)" })

-- Utilities & Scratch
map("n", "<leader>.", function()
  snacks.scratch()
end, { desc = "Scratch Buffer (Quick notes)" })
map("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "Dismiss notifications" })
map("n", "<leader>bd", function()
  snacks.bufdelete()
end, { desc = "Delete buffer" })
map("n", "<leader>bD", function()
  snacks.bufdelete.invisible()
end, { desc = "Delete buffer (invisible)" })

-- Reactive Toggles (integrated with Which-Key)
snacks.toggle.inlay_hints():map("<leader>th")
snacks.toggle.dim():map("<leader>td")
snacks.toggle.diagnostics():map("<leader>tD")
snacks.toggle.line_number():map("<leader>tn")
snacks.toggle.treesitter():map("<leader>tt")
snacks.toggle.words():map("<leader>tw")
snacks.toggle.zen():map("<leader>z")
snacks.toggle.zoom():map("<leader>wm")
snacks.toggle({
  id = "codelens",
  name = "CodeLens",
  get = function()
    return vim.lsp.codelens.is_enabled({ bufnr = 0 })
  end,
  set = function(state)
    vim.lsp.codelens.enable(state, { bufnr = 0 })
  end,
}):map("<leader>tc")
