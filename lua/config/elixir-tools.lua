local elixir = require("elixir")

elixir.setup({
  nextls = {
    enable = true,
  },
  credo = {
    enable = true,
  },
  elixirls = {
    enable = false,
    settings = {
      dialyzerEnabled = false,
    },
  },
  projectionist = {
    enable = true,
  },
})
