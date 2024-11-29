local lualine = require("lualine")

lualine.setup({
    options = {
      icons_enabled = false,
      theme = "powerline", 
      component_separators = { right = "|" },
      section_separators = { right = "|" },
    },
})
