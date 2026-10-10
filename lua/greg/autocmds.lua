vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
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

-- LSP progress notifications with spinner (Neovim 0.10+)
vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("LspProgress", { clear = true }),
  callback = function()
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- Neovim 0.12+: native terminal progress bars via OSC 9;4
vim.api.nvim_create_autocmd("Progress", {
  group = vim.api.nvim_create_augroup("TerminalProgress", { clear = true }),
  callback = function(ev)
    local p = ev.data
    if p then
      io.write(string.format("\27]9;4;%d;%d\7", p.state or 1, p.value or 0))
      io.flush()
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("GitSettings", { clear = true }),
  pattern = { "fugitive", "gitcommit", "git" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Auto-create parent directory when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Close certain utility buffers easily with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true }),
  pattern = { "help", "lspinfo", "man", "qf", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close window" })
  end,
})

-- Neovim 0.12+: gx in help buffers opens the online documentation
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("HelpGotoOnline", { clear = true }),
  pattern = "help",
  callback = function(event)
    vim.keymap.set("n", "gx", function()
      local word = vim.fn.expand("<cWORD>")
      vim.ui.open("https://neovim.io/doc/user/" .. word .. ".html")
    end, { buffer = event.buf, desc = "Open help online" })
  end,
})
