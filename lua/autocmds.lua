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

local fugitive_group = vim.api.nvim_create_augroup("segfvult_fugitive", {})
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
  group = fugitive_group,
  pattern = "*",
  callback = function()
    -- If buffer filetype is not fugitive return
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    -- vim.keymap.set("n", "<leader>p", function()
    --   vim.cmd.Git('push')
    -- end, opts)

    -- rebase always
    vim.keymap.set("n", "<leader>P", ":Git pull --rebase origin ", opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set("n", "<leader>pb", ":Git push -u origin ", opts)
  end,
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

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "nix",
  command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
})
