local lualine = require("lualine")

lualine.setup({
    options = {
      icons_enabled = false,
      theme = "tokyobones",
      component_separators = { right = "|" },
      section_separators = { right = "|" },
    },
})

-- my default theme is usually powerline
-- theme = "powerline", 
-- theme = "poimandres",
-- theme = "tokyonight-night",
