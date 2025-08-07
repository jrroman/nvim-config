return {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
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
  end
}
