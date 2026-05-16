function ColorMe(color, background)
  color = color or "rose-pine"
  background = background or "dark"

  vim.opt.background = background
  vim.cmd.colorscheme(color)
  vim.cmd("highlight Cursor guibg=#8f87ab") -- #605f63
  vim.cmd("highlight lCursor guibg=#8f87ab") -- #605f63
  vim.cmd("highlight Visual guibg=#283975") -- #374578, #0f2f3f
end

require("vague").setup({
  transparent = false,
  italic = false,
  bold = true,
  on_highlights = function(hl, colors)
    -- bring italics back just for comments
    hl.Comment = { fg = colors.comment, italic = true }
    -- treesitter comments too, since those often override
    hl["@comment"] = { fg = colors.comment, italic = true }
  end,
})

-- ColorMe("jr-base16", "dark")
ColorMe("vague", "dark")
-- ColorMe("gruvbox-dark-hard", "dark")
-- ColorMe("rose-pine", "dark")
-- ColorMe("tomorrow-night", "dark")
-- ColorMe("tokyodark-terminal", "dark")
-- ColorMe("tokyo-night-terminal-dark", "dark")
-- ColorMe("classic-dark", "dark")

vim.cmd([[hi Normal ctermbg=NONE]])
-- Less visible window separator
vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })
-- Make background transparent (same color as terminal)
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
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
