local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("i", "jj", "<ESC>", default_opts)
vim.cmd("cabbrev E Explore")
-- telescope
keymap("n", "<Leader>ff", ":Telescope find_files<CR>", default_opts)
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", default_opts)
keymap("n", "<Leader>fb", ":Telescope buffers<CR>", default_opts)
-- nvim tree
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", default_opts)
keymap("n", "<Leader>ef", ":NvimTreeFindFile<CR>", default_opts)
keymap("n", "<Leader>ee", ":NvimTreeFocus<CR>", default_opts)
-- go debugging
keymap("n", "<Leader>db", ":DapToggleBreakpoint<CR>", default_opts)
keymap("n", "<Leader>dc", ":DapContinue<CR>", default_opts)
vim.keymap.set("n", "<Leader>dus", function()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, default_opts)

-- fterm
-- keymap('n', '<Leader>fo', '<CMD>lua require("FTerm").toggle()<CR>', default_opts)
-- virtual text diagnostic messages, will toggle local troubleshoot
keymap("n", "<Leader>fd", "<CMD>lua vim.diagnostic.open_float()<CR>", default_opts)
