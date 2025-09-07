function ColorMe(color, background)
  color = color or "rose-pine"
  background = background or "dark"

  vim.opt.background = background
  if background == "dark" then
    vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
      pattern = "*",
      callback = function()
        -- vim.cmd("highlight CursorLine guibg=#2a263c")
        vim.cmd("highlight Cursor guibg=#605f63")
        vim.cmd("highlight lCursor guibg=#605f63")
        vim.cmd("highlight Visual guibg=#283975") -- #374578, #0f2f3f
      end,
    })
  end

  vim.cmd.colorscheme(color)
end

return {
  {
    "jnurmine/Zenburn",
    name = "zenburn",
    lazy = true,
    config = function()
      vim.g.zenburn_high_Contrast = 0
      vim.g.zenburn_subdued_LineNr = 1
      vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
        pattern = "*",
        command = "highlight Search ctermfg=230 ctermbg=22 guifg=#000000 guibg=#faf8f2",
      })
      -- ColorMe("zenburn", "dark")
    end,
  },

  -- rose pine https://github.com/rose-pine/neovim
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "moon",      -- options are main, moon, dawn
        dark_variant = "moon", -- options are main, moon, dawn
        extend_background_behind_borders = true,
        styles = {
          italic = false,
          transparency = true, -- default false
        },
        enable = {
          terminal = true,
        },
        highlight_groups = {
          -- Normal = { bg = "NONE" }, -- Colors I like #1a1b26, #1f1d2e, #191a22
          -- NormalFloat = { bg = "NONE" },
        },
      })

      ColorMe(nil, "dark")
    end,
  },

  -- tokyonight https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark",   -- style for floating windows
        },
      })

      -- ColorMe("tokyonight", "dark")
    end,
  },
}
