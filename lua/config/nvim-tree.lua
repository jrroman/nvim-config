--local function on_attach(bufnr)
--    local api = require("nvim-tree.api")
--
--    local function opts(desc)
--        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--    end
--
--    vim.keymap.set("n", "e", api.tree.toggle, opts("Toggle Explorer"))
--    vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
--end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      glyphs = {
        default = "-",
      },
      show = {
        file = true,
        folder = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})
