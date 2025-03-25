local oscura = require("oscura");
oscura.setup({
  cursorline = vim.o.cursorline,
  transparent_background = false, -- Set to true for transparent background
  nvim_tree_darker = false,
  undercurl = true,
  italic_string = false,
  italic_keyword = false,
  italic_type = {
    normal = false,
    builtin = false,
    definition = false,
  },
  italic_constant = {
    builtin = false,
  },
  italic_function = {
    declaration = false,
    call = false,
    method = {
      declaration = false,
      call = false,
    },
  },
  custom_dark_background = nil, -- Set a custom background color
  treesitter_context_bg = true,
  float_borderless = false,
})
