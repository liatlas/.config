vim.opt.mouse = ""

vim.o.undofile = true
vim.o.backup = true

local backup_dir = os.getenv("HOME") .. "/.cache/nvim/backups//"
vim.o.backupdir = backup_dir

vim.opt.winborder = "rounded"
vim.g.have_nerd_font = true

vim.opt.clipboard = "unnamedplus"

vim.o.showmode = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.confirm = true
vim.o.wrap = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.cursorline = false
vim.o.scrolloff = 20
vim.o.list = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cc = "40"
