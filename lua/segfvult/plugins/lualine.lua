return {
  "nvim-lualine/lualine.nvim",
  requires = {
    "nvim-tree/nvim-web-devicons",
    opt = true,
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "rose-pine", -- my default is powerline
        component_separators = { right = "|" },
        section_separators = { right = "|" },
      }
    })
  end
}
