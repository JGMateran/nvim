vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
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

    map("n", "gD", vim.lsp.buf.declaration, { desc = "Show declaration" })
    map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Show definitions" })
    map("n", "K", vim.lsp.buf.hover, { desc = "Display detailed information about the symbol under the cursor" })
    map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Show implementations" })
    map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
    map("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "List workspace folders" })
    map("n", "<space>D", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Show type definitions" })
    map("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
    map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
    map("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format document" })

    map("n", "<space>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
    map("n", "<space>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
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

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
          or " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
