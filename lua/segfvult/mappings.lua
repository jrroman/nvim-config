-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = "\\"
vim.g.maplocalleader = "]"

local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Open netrw
--vim.cmd("cabbrev E Explore")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Remove mapping for Q which is used to quit a buffer.
vim.keymap.set("n", "Q", "<nop>")

-- Exit insert mode.
vim.keymap.set("i", "jj", "<ESC>", default_opts)

-- Replace word under cursor.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move highlighted lines under cursor.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") 
-- Keep cursor in same position when moving lines.
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in middle when paging up and down.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Keep cursor in middle when searching for next match.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Dont lose paste buffer, delete highlighted word to void register. 
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Nvim tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", default_opts)
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", default_opts)
vim.keymap.set("n", "<leader>ee", ":NvimTreeFocus<CR>", default_opts)

-- Mason
vim.keymap.set("n", "<leader>m", ":Mason<CR>", default_opts)

-- Copy to system clipboard.
vim.keymap.set("n", "<leader>y", "\"+y", default_opts)
vim.keymap.set("v", "<leader>y", "\"+y", default_opts)

-- Lazy
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", default_opts)

-- Fterm
-- vim.keymap.set('n', '<leader>fo', '<CMD>lua require("FTerm").toggle()<CR>', default_opts)
-- virtual text diagnostic messages, will toggle local troubleshoot
-- Telescope
--vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", default_opts)
--vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", default_opts)
--vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", default_opts)

vim.keymap.set("n", "<leader>fd", "<CMD>lua vim.diagnostic.open_float()<CR>", default_opts)
