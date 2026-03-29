function ColorMe(color, background)
  color = color or "rose-pine"
  background = background or "dark"

  vim.opt.background = background
  vim.cmd.colorscheme(color)
  vim.cmd("highlight Cursor guibg=#605f63")
  vim.cmd("highlight lCursor guibg=#605f63")
  vim.cmd("highlight Visual guibg=#283975") -- #374578, #0f2f3f
end

return {
  {
    "wincent/base16-nvim",
    name = "base16-nvim",
    lazy = false, -- load at start
    priority = 1000, -- load first
    config = function()
      ColorMe("jr-base16", "dark")

      vim.o.background = "dark"
      vim.cmd([[hi Normal ctermbg=NONE]])
      -- Less visible window separator
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })
      -- Make comments more prominent -- they are important.
      -- local bools = vim.api.nvim_get_hl(0, { name = "Boolean" })
      -- vim.api.nvim_set_hl(0, "Comment", bools)
      -- Make it clearly visible which argument we're at.
      local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
      vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
        fg = marked.fg,
        bg = marked.bg,
        ctermfg = marked.ctermfg,
        ctermbg = marked.ctermbg,
        bold = true,
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon", -- options are main, moon, dawn
        dark_variant = "moon", -- options are main, moon, dawn
        extend_background_behind_borders = true,
        styles = {
          italic = false,
          bold = true,
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

      -- ColorMe(nil, "dark")
    end,
  },

  -- https://github.com/vague-theme/vague.nvim
  {
    "vague-theme/vague.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
        transparent = false,
        bold = true,
        italic = false,
        colors = {},
      })

      -- ColorMe("vague", "dark")
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
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        cache = true,
      })

      -- ColorMe("tokyonight", "dark")
    end,
  },
}
