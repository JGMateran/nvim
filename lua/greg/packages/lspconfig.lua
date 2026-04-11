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

-- 1. Setup lazydev (must be before lspconfig)
lazydev.setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})

-- 2. Configure diagnostics (Modern 0.12 syntax)
vim.diagnostic.config({
  virtual_lines = true, -- Highlight of 0.11+
  virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
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

-- 3. Mason & LSP Servers setup
local capabilities = require("blink-cmp").get_lsp_capabilities()

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
  jsonls = {},
  gopls = {},
  phpactor = {},
  intelephense = {},
}

mason.setup({
  ui = { border = "rounded", width = 0.8, height = 0.8 },
})

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, { "stylua", "eslint_d", "goimports", "gofumpt" })

mason_tool_installer.setup({ ensure_installed = ensure_installed })

mason_lspconfig.setup({
  handlers = {
    function(server_name)
      local server_opts = servers[server_name] or {}
      server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})

      -- Using lspconfig for now as it's more stable for Mason integration
      lspconfig[server_name].setup(server_opts)
    end,
  },
})

-- 4. Unified LspAttach Autocommand
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(e)
    local client = vim.lsp.get_client_by_id(e.data.client_id)
    if not client then
      return
    end

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = e.buf, desc = "LSP: " .. desc })
    end

    -- Premium Telescope mappings (Keep these!)
    map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
    map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", "Go to implementations")
    map("n", "grr", "<cmd>Telescope lsp_references<cr>", "Show references")
    map("n", "grt", "<cmd>Telescope lsp_type_definitions<cr>", "Go to type definition")

    -- Neovim 0.12 Standard Mappings (The new convention)
    map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "x" }, "gra", vim.lsp.buf.code_action, "Code action")

    -- Other useful ones
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gO", vim.lsp.buf.document_symbol, "Document symbols (Outline)")
    map("n", "<C-k>", function()
      vim.lsp.buf.signature_help({ border = "rounded" })
    end, "Signature help")

    -- Workspace Management
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")

    -- Formatting
    map("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format document")
  end,
})

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Floating diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })
