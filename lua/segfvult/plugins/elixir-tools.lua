return {
  {
    {
      "emmanueltouzery/elixir-extras.nvim",
      dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
      "elixir-tools/elixir-tools.nvim",
      tag = "stable",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("elixir").setup({
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
      end
    }
  }
}

