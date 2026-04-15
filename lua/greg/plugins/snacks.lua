vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local snacks = require("snacks")

snacks.setup({
  input = {},
  select = {},
  notifier = {},
  picker = {
    layout = {
      backdrop = false,
    },
    win = {
      input = { backdrop = false },
      list = { backdrop = false },
      preview = { backdrop = false },
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

-- MAPPINGS DE SNACKS
local map = vim.keymap.set

-- Explorador
map("n", "<leader><tab>", function()
  snacks.explorer()
end, { desc = "Toggle Snacks Explorer" })

-- Buscadores (Picker)
map("n", "<leader>ff", function()
  snacks.picker.files()
end, { desc = "Snacks: Buscar Archivos" })
map("n", "<leader>fb", function()
  snacks.picker.buffers()
end, { desc = "Snacks: Buscar Buffers" })
map("n", "<leader>fg", function()
  snacks.picker.grep()
end, { desc = "Snacks: Grep Global" })
map("n", "<leader>fh", function()
  snacks.picker.help()
end, { desc = "Snacks: Ayuda" })
map("n", "<leader>fr", function()
  snacks.picker.recent()
end, { desc = "Snacks: Recientes" })

-- Git
map("n", "<leader>ge", function()
  snacks.picker.git_status()
end, { desc = "Git Explorer (Snacks)" })
map("n", "<leader>gl", function()
  snacks.picker.git_log()
end, { desc = "Git Log (Snacks)" })

-- Utilidades
map("n", "<leader>z", function()
  snacks.zen()
end, { desc = "Alternar Modo Zen" })
map("n", "<leader>.", function()
  snacks.scratch()
end, { desc = "Scratch Buffer (Notas rápidas)" })
map("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "Limpiar Notificaciones" })
