return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",

        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
        file_ignore_patterns = {
          "node_modules",
        },
        preview = false,
      },
    },
    config = function(_, opts)
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      require("telescope").setup(opts)

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Open find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Open grep" })
      vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Open buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Open help tags" })

      vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Open old files" })
      vim.keymap.set("n", "sw", builtin.grep_string, {})

      vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    end,
  },
}
