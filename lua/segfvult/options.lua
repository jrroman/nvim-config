vim.opt.guicursor = "n-c-v-i-ci:block-Cursor,r-cr:blinkon200-blinkoff150-Cursor"

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.wrap = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.updatetime = 250
--vim.opt.colorcolumn = "80"

-- for obsidian markdown
vim.opt_local.conceallevel = 1
vim.opt.conceallevel = 1
