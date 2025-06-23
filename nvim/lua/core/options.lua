local opt = vim.opt

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line numbers
opt.number = true
opt.relativenumber = true

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undodir")

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Visual
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
-- opt.colorcolumn = "80"  -- Removed this line to eliminate the column
opt.cursorline = true

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Timing
opt.updatetime = 50
opt.timeoutlen = 300

-- Performance
opt.lazyredraw = true
opt.ttyfast = true
opt.regexpengine = 1
