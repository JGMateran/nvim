return {
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    keys = {
      {
        "<leader>rr",
        function()
          vim.cmd.RustLsp("runnables")
        end,
      },
    },
  },
}
