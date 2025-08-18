return {
  {
    "jnurmine/Zenburn",
    name = "zenburn",
    config = function()
      vim.g.zenburn_high_Contrast = 0
      vim.g.zenburn_subdued_LineNr = 1
      vim.api.nvim_create_autocmd(
        { "VimEnter", "WinEnter" },
        {
          pattern = "*",
          command = "highlight Search ctermfg=230 ctermbg=22 guifg=#000000 guibg=#faf8f2",
        }
      )
      -- vim.cmd("colorscheme zenburn")
    end
  },

  -- rose pine https://github.com/rose-pine/neovim
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        extend_background_behind_borders = false,
        styles = {
          italic = false,
          transparency = false, -- default false
        },
        highlight_groups = {
          Normal = { bg = "#1a1b26" }, -- Colors I like #1a1b26, #1f1d2e, #191a22
          NormalFloat = { bg = "#1a1b26" },
        },
      })

      -- cursor and cursorline highlighting
      vim.api.nvim_create_autocmd(
        { "VimEnter", "WinEnter" },
        {
          pattern = "*",
          callback = function()
            vim.cmd("highlight CursorLine guibg=#2a263c")
            vim.cmd("highlight Cursor guibg=#605f63")
            vim.cmd("highlight lCursor guibg=#605f63")
            vim.cmd("highlight Visual guibg=#0f2f3f")
          end
        }
      )
      vim.cmd.colorscheme("rose-pine")
    end
  },
}
