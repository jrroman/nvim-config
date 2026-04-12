require("conform").setup({
  formatters_by_ft = {
    cpp = { "clang-format" },
    c = { "clang-format" },
    elixir = { "mix" },
    go = { "goimports" },
    javascript = { "deno_fmt" },
    lua = { "stylua" },
    python = { "black" },
    rust = { "rustfmt" },
    typescript = { "deno_fmt" },
    typescriptreact = { "deno_fmt" },
  },
  -- format_on_save = {
  --   lsp_format = "first",
  -- },
})

vim.keymap.set("n", "<leader>fmt", function()
  require("conform").format({ bufnr = 0 })
end)
