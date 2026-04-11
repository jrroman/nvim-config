vim.opt.guicursor = "n-c-v:block-Cursor,"
  .. "i-ci:block-Cursor-blinkon200-blinkoff150,"
  .. "r-cr:hor25-Cursor-blinkon200-blinkoff150"

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:1"

vim.opt.wrap = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.updatetime = 250

vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'
vim.opt.confirm = true

--vim.opt.colorcolumn = "80"
