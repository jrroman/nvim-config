vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>xd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>xD', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>xs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>xS', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>xh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>xic', vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set('n', '<Leader>xoc', vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set('n', '<Leader>xr', vim.lsp.buf.references, opts)
  end
})

-- Here we set the color of the cursor number row, cursor color, and cursor line
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter" },
  { 
    pattern = "*",
    callback = function()
      -- Highlight column only when characters surpass 80 columns
      vim.cmd("highlight EightyChars ctermbg=lightred guibg=lightred ctermfg=black guifg=black")
      vim.fn.matchadd('EightyChars', '\\%79v', 100)

      -- Set number row highlight color
      vim.cmd("highlight CursorLineNr ctermbg=lightred guibg=lightred ctermfg=black guifg=black")
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

-- autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab 
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = "html",
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
-- This will format JSON files using jq when you run the `gq` command
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = "json",
    command = "setlocal formatprg=jq",
  }
)
