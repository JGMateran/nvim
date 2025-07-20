vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/saghen/blink.cmp",
})

local lazydev = require("lazydev")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
local lspconfig = require("lspconfig")

-- Use capabilities from blink.cmp
local capabilities = require("blink-cmp").get_lsp_capabilities()

-- Merged list of servers from both files
local servers = {
  astro = {},
  bashls = {},
  cssls = {},
  emmet_language_server = {},
  html = {},
  lua_ls = {},
  prismals = {},
  tailwindcss = {},
  ts_ls = {},
  stylua = {},
  eslint_d = {},
  jsonls = {},
  gopls = {},
  goimports = {},
  gofumpt = {},
  prettierd = {},
}

-- Setup mason
mason.setup({
  ui = {
    width = 0.7,
    height = 0.7,
    border = "rounded",
  },
})

-- Ensure servers are installed
local ensure_installed = vim.tbl_keys(servers)
mason_tool_installer.setup({
  ensure_installed = ensure_installed,
})

-- Setup mason-lspconfig to handle server configurations
mason_lspconfig.setup({
  handlers = {
    function(server_name)
      local server_opts = servers[server_name] or {}

      -- Combine global capabilities with server-specific ones
      server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})

      lspconfig[server_name].setup(server_opts)
    end,
  },
})

-- Setup lazydev for lua development
lazydev.setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})

-- Configure diagnostics
vim.diagnostic.config({
  float = {
    border = "rounded",
    max_width = 80,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
})

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

-- LSP Attach Autocommand
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(e)
    vim.bo[e.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = e.buf
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "gD", vim.lsp.buf.declaration, { desc = "Show declaration" })
    map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Show definitions" })
    map("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded", max_width = 80 })
    end, { desc = "Display detailed information about the symbol under the cursor" })
    map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Show implementations" })
    map("n", "<C-k>", function()
      vim.lsp.buf.signature_help({ border = "rounded", max_width = 80 })
    end, { desc = "Show signature help" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
    map("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "List workspace folders" })
    map("n", "<space>D", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Show type definitions" })
    map("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
    map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    map("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format document" })
    map("n", "<space>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
    map("n", "<space>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
  end,
})

-- Diagnostic Keymaps
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open a floating message for the diagnostic" })
vim.keymap.set("n", "<space>[d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to the previous diagnostic." })
vim.keymap.set("n", "<space>]d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to the next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set the diagnostic location list" })
