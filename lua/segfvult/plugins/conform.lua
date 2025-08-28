return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
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
      format_on_save = {
        lsp_format = "first",
      },
    })
  end,
}
