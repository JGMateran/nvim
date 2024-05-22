local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local function load_signs(sign_icons)
  for name, text in pairs(sign_icons) do
    vim.fn.sign_define(name, {
      texthl = name,
      text = text,
      numhl = "",
    })
  end
end

load_signs({
  DiagnosticSignError = "",
  DiagnosticSignWarn = "",
  DiagnosticSignHint = "",
  DiagnosticSignInfo = " ",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "alpha",
    "dashboard",
    "neo-tree",
    "Trouble",
    "lazy",
    "mason",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(e)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[e.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = e.buf
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to definition" })
    map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
    map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP implementations" })
    map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP remove workspace folder" })
    map("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "LSP list workspace folders" })
    map("n", "<space>D", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "LSP type definition" })
    map("n", "<space>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
    map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })
    map("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "LSP format" })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("ResizeSplit", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})
