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
      -- ColorMe("jr-base16", "dark")
      -- ColorMe("gruvbox-dark-hard", "dark")
      -- ColorMe("tomorrow-night", "dark")
      ColorMe("tokyo-night-terminal-dark", "dark")
      -- ColorMe("tokyodark-terminal", "dark")
      -- ColorMe("rose-pine", "dark")

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
}
