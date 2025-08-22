return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        cpp = { "clang-format" },
        c = { "clang-format" },
        lua = { "stylua" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        javascript = { "deno_fmt" },
        typescript = { "deno_fmt" },
        elixir = { "mix" }
      }
    })
  end
}
