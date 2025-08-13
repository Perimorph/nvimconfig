-- ===============================
--    Neovim Rust IDE Setup
-- ===============================

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers (relative + absolute)
vim.opt.number = true
vim.opt.relativenumber = true

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({

  -- LSP configuration
  { "neovim/nvim-lspconfig" },

  -- Rust tools
  { "simrat39/rust-tools.nvim" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Colorscheme
  { "scottmckendry/cyberdream.nvim" },

  -- Autobracket
  { "windwp/nvim-autopairs", config = true },

  -- Startup screen
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end
  },
})

-- ===============================
--         Plugin Config
-- ===============================

-- LSP + Rust Tools with crate doc & inlay hints
require("rust-tools").setup({
  server = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        procMacro = { enable = true },
        hover = { documentation = true },
        completion = { fullFunctionSignatures = { enable = true } },
        inlayHints = {
          typeHints = { enable = true },
          parameterHints = { enable = true },
          chainingHints = { enable = true },
        },
      },
    },
    on_attach = function(_, bufnr)
      local opts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end,
  },
})

-- Autocompletion setup
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }
})

-- Treesitter setup
require("nvim-treesitter.configs").setup({
  ensure_installed = { "rust", "lua", "vim", "markdown" },
  highlight = { enable = true }
})

-- Telescope basic keybind
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {})

-- Colorscheme
vim.cmd.colorscheme("cyberdream")

