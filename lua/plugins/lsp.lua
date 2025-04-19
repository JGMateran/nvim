local config = require("greg.config")
local lsp_kind = config.icons.kinds

---@class CmpFormatOptions
---@field maxWidth number

---@param opts CmpFormatOptions
local function cmp_format(opts)
  return function(_, item)
    if lsp_kind[item.kind] then
      item.kind = lsp_kind[item.kind]
    end

    item.menu = ""

    if #item.abbr > opts.maxWidth then
      item.abbr = item.abbr:sub(1, opts.maxWidth) .. "…"
    end

    return item
  end
end

local servers = {
  astro = {},
  bashls = {},
  cssls = {},
  emmet_ls = {
    filetypes = {
      "html",
      "javascriptreact",
      "typescriptreact",
    },
  },
  html = {},
  lua_ls = {},
  -- prismals = {},
  -- pyright = {},
  tailwindcss = {},
  ts_ls = {},
  stylua = {},
  eslint_d = {},
  jsonls = {},
}

return {
  {

    "williamboman/mason.nvim",
    opts = {
      ui = {
        width = 0.7,
        height = 0.7,
        border = "rounded",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "williamboman/mason.nvim",
    },
    keys = {
      { "<space>e", vim.diagnostic.open_float, desc = "Open a floating message for the diagnostic" },
      {
        "<space>[d",
        function()
          vim.diagnostic.jump({
            count = 1,
            float = true,
          })
        end,
        desc = "Go to the previous diagnostic.",
      },
      {
        "<space>]d",
        function()
          vim.diagnostic.jump({
            count = -1,
            float = true,
          })
        end,
        desc = "Go to the next diagnostic",
      },
      { "<space>q", vim.diagnostic.setloclist, desc = "Set the diagnostic location list" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

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
          map("n", "K", function()
            vim.lsp.buf.hover({
              border = "rounded",
              max_width = 80,
            })
          end, { desc = "Display detailed information about the symbol under the cursor" })
          map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Show implementations" })
          map("n", "<C-k>", function()
            vim.lsp.buf.signature_help({
              border = "rounded",
              max_width = 80,
            })
          end, { desc = "Show signature help" })
          map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
          map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
          map("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "List workspace folders" })
          map("n", "<space>D", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Show type definitions" })
          map("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
          map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code action" })
          -- map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
          map("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, { desc = "Format document" })

          map("n", "<space>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
          map("n", "<space>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
        end,
      })

      require("mason-tool-installer").setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      ---@diagnostic disable: missing-fields
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

            lspconfig[server_name].setup(server)
          end,
        },
      })

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
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      -- "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      luasnip.config.setup({})
      -- require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        ---@diagnostic disable: missing-fields
        matching = {
          disallow_symbol_nonprefix_matching = false,
        },
      })

      ---@diagnostic disable: missing-fields
      cmp.setup({
        formatting = {
          format = cmp_format({
            maxWidth = 20,
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            scrollbar = false,
          }),
          documentation = cmp.config.window.bordered({
            scrollbar = false,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable(-1) then
              luasnip.expand_or_jump(-1)
            else
              fallback()
            end
          end),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "crates" },
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
  },
}
