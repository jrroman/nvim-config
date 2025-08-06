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
  hijack_cursor = true,
  sync_root_with_cwd = true,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    group_empty = true,
    indent_markers = { enable = true },
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
    custom = {
      "^.git$",
    },
  },
})
