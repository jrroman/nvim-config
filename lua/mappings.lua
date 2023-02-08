local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("i", "jj", "<ESC>", default_opts)
keymap("n", "<Leader>ff", ":Telescope find_files<CR>", default_opts)
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", default_opts)
keymap("n", "<Leader>fb", ":Telescope buffers<CR>", default_opts)
