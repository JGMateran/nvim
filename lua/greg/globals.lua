vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Split windows
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current

vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.smoothscroll = true

-- Mouse and clipboard
vim.opt.mouse = "a"
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Undo and swap
vim.opt.undofile = true
vim.opt.swapfile = false

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Signcolumn & update timing
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Completion
vim.opt.completeopt = "menuone,noselect"
vim.opt.pumborder = "rounded"
vim.opt.pummaxwidth = 60

-- Floating window borders
vim.opt.winborder = "rounded"

-- Terminal and display
vim.opt.termguicolors = true
vim.opt.scrolloff = 8

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.laststatus = 3
vim.opt.background = "dark"

-- Experimental Neovim 0.12+ UI redesign (ui2)
-- Provides a cleaner command line and message experience.
-- It avoids "Press ENTER" and improves the message pager.
if vim.version().minor >= 12 then
  pcall(function()
    require("vim._core.ui2").enable()
  end)
end

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldtext = ""

-- Modern Diff UI Settings (Neovim 0.10+ / 0.12+)
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "hiddenoff",
  "algorithm:histogram",
  "linematch:60",
  "inline:word",
}

-- Remove the dashed lines "----" in diff filler areas
vim.opt.fillchars:append({ diff = " " })
