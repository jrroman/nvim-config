local elixir = require("elixir")

elixir.setup({
  nextls = {
    enable = true,
  },
  credo = {
    enable = true,
  },
  elixirls = {
    enable = true,
    settings = {
      dialyzerEnabled = true,
    },
  },
  projectionist = {
    enable = true,
  },
})
