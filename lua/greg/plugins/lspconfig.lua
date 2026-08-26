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
local mason_tool_installer = require("mason-tool-installer")

lazydev.setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})

mason.setup({
  ui = { border = "rounded", width = 0.8, height = 0.8 },
})

local icons = require("greg.config").icons

local lsp_servers = {
  "lua_ls",
  "jsonls",
  "html",
  "emmet_language_server",
  "cssls",
  "ts_ls",
  "bashls",
  "tailwindcss",
  "biome",
}

local tools = {
  "stylua",
  "eslint_d",
  "prettierd",
}

mason_tool_installer.setup({
  ensure_installed = vim.list_extend(vim.deepcopy(lsp_servers), tools),
})

vim.lsp.enable(lsp_servers)

if vim.lsp.document_color then
  vim.lsp.document_color.enable(true, nil, { style = "virtual" })
end

vim.diagnostic.config({
  virtual_lines = false,
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
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    },
  },
})

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

    if client.server_capabilities.inlineCompletionProvider then
      vim.lsp.completion.enable(true, client.id, e.buf, { autostart = true })
    end

    -- Enable Inlay Hints if supported
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = e.buf })
    end

    -- Enable CodeLens if supported (Neovim 0.12+ auto-manages refreshing)
    if client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.enable(true, { bufnr = e.buf })
    end

    map("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, "Go to definition")
    map("n", "gi", function()
      Snacks.picker.lsp_implementations()
    end, "Go to implementations")
    map("n", "grr", function()
      Snacks.picker.lsp_references()
    end, "Show references")
    map("n", "grt", function()
      Snacks.picker.lsp_type_definitions()
    end, "Go to type definition")

    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

    map("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 30 })
    end, "LSP Hover")

    map({ "n", "i" }, "<C-k>", function()
      vim.lsp.buf.signature_help({ border = "rounded" })
    end, "Signature help")

    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>cl", vim.lsp.codelens.run, "Run CodeLens")

    -- Toggles
    map("n", "<leader>th", function()
      local current = vim.lsp.inlay_hint.is_enabled({ bufnr = e.buf })
      vim.lsp.inlay_hint.enable(not current, { bufnr = e.buf })
    end, "Toggle Inlay Hints")

    map("n", "<leader>tc", function()
      local current = vim.lsp.codelens.is_enabled({ bufnr = e.buf })
      vim.lsp.codelens.enable(not current, { bufnr = e.buf })
    end, "Toggle CodeLens")

    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")

    map("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format document")
  end,
})

-- Diagnostic mappings with auto-float
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Floating diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { desc = "Next Error" })
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { desc = "Prev Error" })
