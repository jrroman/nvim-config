local o = vim.opt

o.smartindent = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.number = true
o.swapfile = false
o.cursorline = true
-- o.colorcolumn = "80"

-- Both of the below commands should highlight the column dark red and the text
-- should be white however they do not seem to work
--vim.cmd("highlight ColorColumn guibg=DarkRed guifg=White")
--vim.cmd([[highlight ColorColumn guibg=DarkRed guifg=White]])
--vim.api.nvim_set_hl(0, "ColorColumn", { bg="DarkRed", fg="White" })

-- Highlight column only when characters surpass 80 columns
vim.api.nvim_create_autocmd(
    { "VimEnter", "WinEnter" },
    { 
        pattern = "*",
        callback = function()
            vim.fn.matchadd('ColorColumn', '\\%79v', 100)
        end
    }
)
