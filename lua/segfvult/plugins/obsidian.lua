return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  config = function()
    require("obsidian").setup({
      legacy_commands = false,
      workspaces = {
        {
          name = "jr",
          path = "~/Documents/obsidian/JR",
        },
      },
      completion = {
        -- Enables completion using nvim_cmp
        nvim_cmp = true,
      },
      ui = {
        enable = true,
        ignore_conceal_warn = false,
      }
    })
  end
}
