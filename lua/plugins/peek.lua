require("peek").setup({
  filetype = { "markdown", "conf" },
  theme = "dark",
  app = "browser",
  syntax = true,
  update_on_change = true,
})

vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
