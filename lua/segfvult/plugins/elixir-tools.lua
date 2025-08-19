return {
  {
    {
      "emmanueltouzery/elixir-extras.nvim",
      dependencies = { "nvim-telescope/telescope.nvim" },
      ft = { "elixir", "eelixir", "heex", "surface" },
    },
    {
      "elixir-tools/elixir-tools.nvim",
      tag = "stable",
      ft = { "elixir", "eelixir", "heex", "surface" },
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("elixir").setup({
          nextls = {
            enable = false,
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
      end
    }
  }
}

