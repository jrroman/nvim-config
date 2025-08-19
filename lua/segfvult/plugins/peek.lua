return {
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    lazy = true,
    ft = { "markdown" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        filetype = { 'markdown', 'conf' }
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
