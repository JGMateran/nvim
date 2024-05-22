return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage current hunk" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage selected lines" })

        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset current hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset selected lines" })

        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage entire buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo last hunk staging" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset entire buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview current hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame current line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame for current line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff preview current line" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Diff preview current line with previous version" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted lines" })

        map(
          { "o", "x" },
          "ih",
          ":<C-U>Gitsigns select_hunk<CR>",
          { desc = "Select current hunk in insert or visual mode" }
        )
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>gg", "<cmd>G<cr>", desc = "Git status" },
      { "<leader>gc", "<cmd>G commit<cr>", desc = "Git commit" },
      { "<leader>gu", "<cmd>G push<cr>", desc = "Git push" },
      { "<leader>gp", "<cmd>G pull<cr>", desc = "Git pull" },
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff" },
      { "<leader>gb", "<cmd>G blame<cr>", desc = "Git blame" },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Open file history in Diffview" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
  },
}
