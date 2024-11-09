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
-- autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "javascript",
        command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
    }
)
-- autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "javascriptreact",
        command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
    }
)
-- autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "typescript",
        command = "setlocal sw=2 softtabstop=2 expandtab",
    }
)
-- autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "typescriptreact",
        command = "setlocal sw=2 softtabstop=2 expandtab",
    }
)
-- autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "css",
        command = "setlocal sw=2 softtabstop=2 expandtab",
    }
)
-- autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab 
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "python",
        command = "setlocal sw=4 softtabstop=4 expandtab",
    }
)

-- autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "lua",
        command = "setlocal sw=2 softtabstop=2 expandtab",
    }
)
