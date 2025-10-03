-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local default_opts = { noremap = true, silent = true }

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

-- Mason
vim.keymap.set("n", "<leader>m", ":Mason<CR>", default_opts)

vim.keymap.set("n", "<leader>fmt", function()
  require("conform").format({ bufnr = 0 })
end)

-- Copy to system clipboard.
vim.keymap.set("n", "<leader>y", '"+y', default_opts)
vim.keymap.set("v", "<leader>y", '"+y', default_opts)

-- Lazy
vim.keymap.set("n", "<leader><space>", ":Lazy<CR>", default_opts)

vim.keymap.set("n", "<leader>fd", "<CMD>lua vim.diagnostic.open_float()<CR>", default_opts)

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", default_opts)

-- Spawn a small terminal below the current open window.
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
end)

-- Quickfix
vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>")

-- vim.keymap.set("n", "G", function()
--   vim.cmd("normal! G")
--   vim.cmd("normal! z.")
-- end)
