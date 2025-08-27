return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        cpp = { "clang-format" },
        c = { "clang-format" },
        lua = { "stylua" },
        go = { "goimports" },
        rust = { "rustfmt" },
        javascript = { "deno_fmt" },
        typescript = { "deno_fmt" },
        typescriptreact = { "deno_fmt" },
        elixir = { "mix" },
      },
      format_on_save = {
        lsp_format = "first",
      },
    })
  end,
}
