vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }
    local border_style = "rounded"
    vim.keymap.set("n", "<Leader>ld", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<Leader>li", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>ls", function()
      vim.lsp.buf.signature_help({ border = border_style })
    end, opts)
    vim.keymap.set("n", "<Leader>lh", function()
      vim.lsp.buf.hover({ border = border_style })
    end, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<Leader>lt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<Leader>lic", vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set("n", "<Leader>loc", vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.references, opts)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- TODO: find some way to make this only apply to the current line.
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end

    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- Here we set the color of the cursor number row, cursor color, and cursor line
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
  pattern = "*",
  callback = function()
    -- Highlight column only when characters surpass 80 columns
    vim.cmd("highlight EightyChars ctermbg=lightred guibg=lightred ctermfg=black guifg=black")
    vim.fn.matchadd("EightyChars", "\\%79v", 100)

    -- Set number row highlight color
    vim.cmd("highlight CursorLineNr ctermbg=lightred guibg=lightred ctermfg=black guifg=black")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg and vim.fn.isdirectory(arg) == 1 then
      local abs = vim.fn.fnamemodify(arg, ":p")
      -- close netrw on "nvim ." so only the picker shows
      vim.cmd("bdelete")
      require("snacks").picker.files({ cwd = abs })
    end
  end,
})

-- set filetype for .h header files as c or cpp based on other program files in dir
vim.filetype.add({
  extension = {
    h = function(path, bufnr)
      local dir = vim.fn.fnamemodify(path, ":h")
      local cpp_extensions = { "*.cpp", "*.cc", "*.cxx" }
      for _, ext in ipairs(cpp_extensions) do
        if #vim.fn.glob(dir .. "/" .. ext, false, true) > 0 then
          return "cpp"
        end
      end
      return "c"
    end,
  },
})

-- autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "javascript",
  command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
})

-- autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "javascriptreact",
  command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
})

-- autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "typescript",
  command = "setlocal sw=2 softtabstop=2 expandtab",
})

-- autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "typescriptreact",
  command = "setlocal sw=2 softtabstop=2 expandtab",
})

-- autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "css",
  command = "setlocal sw=2 softtabstop=2 expandtab",
})

-- autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "html",
  command = "setlocal sw=2 softtabstop=2 expandtab",
})

-- autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "python",
  command = "setlocal sw=4 softtabstop=4 expandtab",
})

-- autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "lua",
  command = "setlocal sw=2 softtabstop=2 expandtab",
})

-- autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "jsonc",
  command = "setlocal sw=2 softtabstop=2 expandtab",
})

-- haskell
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "haskell",
  command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
})

-- sql
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "sql",
  command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
})

-- autocmd FileType json set formatprg=jq
-- This will format JSON files using jq when you run the `gq` command
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "json",
  command = "setlocal formatprg=jq",
})
