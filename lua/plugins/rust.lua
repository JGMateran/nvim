return {
  {
    "rust-lang/rust.vim",
    enabled = false,
    ft = { "rust" },
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    ft = { "rust", "toml" },
    tag = "stable",
    config = function()
      require("crates").setup({})
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
    ft = { "rust" },
    lazy = false,
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("run")
          end, { desc = "Rust Run", buffer = bufnr })
        end,
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}
