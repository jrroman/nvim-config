local o = vim.opt

o.smartindent = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.number = true
o.swapfile = false
o.cursorline = true
-- o.colorcolumn = "80"

-- Highlight column only when characters surpass 80 columns
vim.api.nvim_create_autocmd(
    { "VimEnter", "WinEnter"},
    { 
        pattern = "*",
        callback = function()
            vim.fn.matchadd('ColorColumn', '\\%79v', 100)
        end
    }
)
