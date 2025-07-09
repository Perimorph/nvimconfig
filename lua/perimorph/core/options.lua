vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs
opt.tabstop = 2
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- anoying backspace fix
opt.backspace = "indent,eol,start"

-- search fixes
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true

-- window splits
opt.splitright = true
opt.splitbelow = true

-- custom shiii
opt.termguicolors = true
opt.background = "dark" -- fuck light themes
opt.signcolumn = "yes"

-- NOTICE; COPY IN NEOVIM STUFF: DO NOT TOUCH
opt.clipboard:append("unnamedplus")


