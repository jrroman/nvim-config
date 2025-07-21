-- Highlight column only when characters surpass 80 columns
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter" },
  { 
    pattern = "*",
    callback = function()
      vim.cmd("highlight EightyChars ctermbg=lightred guibg=lightred ctermfg=black guifg=black")
      vim.fn.matchadd('EightyChars', '\\%79v', 100)
    end
  }
)

-- Here we set the color of the cursor number row, cursor color, and cursor line
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter" },
  { 
    pattern = "*",
    callback = function()
      vim.cmd("highlight CursorLineNr ctermbg=lightred guibg=lightred ctermfg=black guifg=black")
    end
  }
)

-- Set cursor line colors
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter" },
  {
    pattern = "*",
    callback = function()
      vim.cmd("highlight CursorLine guibg=#434443")
    end
  }
)

-- Set visual mode colors
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter" },
  {
    pattern = "*",
    callback = function()
      vim.cmd("highlight Visual ctermbg=white ctermfg=white guifg=#a1a1a1 guibg=#2f2f2f")
      -- Visual ctermfg=0 ctermbg=235 guibg=#2f2f2f
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

-- autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
      pattern = "jsonc",
      command = "setlocal sw=2 softtabstop=2 expandtab",
  }
)

-- autocmd FileType json set formatprg=jq
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = "json",
    command = "setlocal formatprg=jq",
  }
)
