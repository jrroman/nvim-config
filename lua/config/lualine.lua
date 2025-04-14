local lualine = require("lualine")

lualine.setup({
    options = {
      icons_enabled = false,
      theme = "powerline",
      component_separators = { right = "|" },
      section_separators = { right = "|" },
    },
})

-- my default theme is usually powerline
-- theme = "powerline", 
-- theme = "poimandres",
-- theme = "tokyonight-night",
-- theme = "tokyobones",
-- theme = "gruvbox-material",
