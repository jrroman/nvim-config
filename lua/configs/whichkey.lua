require("which-key").setup({})

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false, loop = true })
end, { desc = "Buffer Local Keymaps (which-key)" })
