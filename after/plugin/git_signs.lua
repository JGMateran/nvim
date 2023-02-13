local ok, gitsigns = pcall(require, 'gitsigns')

if not ok then
  return
end

local on_attach = function()
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
  map('n', '<leader>hp', gs.preview_hunk)
  map('n', '<leader>tb', gs.toggle_current_line_blame)
  map('n', '<leader>hd', gs.diffthis)

  map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
end

gitsigns.setup({
  on_attach = on_attach,

  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "▎", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "▎", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    untracked = { hl = 'GitSignsAdd'   , text = "▎", numhl='GitSignsAddNr'   , linehl='GitSignsAddLn' },
  }
})
