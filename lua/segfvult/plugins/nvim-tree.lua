return {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { "<leader>e",  ":NvimTreeToggle<CR>",   mode = "n" },
    { "<leader>ef", ":NvimTreeFindFile<CR>", mode = "n" },
    { "<leader>ee", ":NvimTreeFocus<CR>",    mode = "n" },
  },
  config = function()
    local function open_win_config()
      local win_w = vim.opt.columns:get()
      local win_h = vim.opt.lines:get()
      local tree_w = 80
      local tree_h = math.floor(tree_w * win_h / win_w)

      return {
        border = "rounded",
        relative = "editor",
        width = tree_w,
        height = tree_h,
        col = math.floor((win_w - tree_w) / 2 - 1),
        row = math.floor((win_h - tree_h) / 2 - 1),
      }
    end

    require("nvim-tree").setup({
      hijack_cursor = true,
      sync_root_with_cwd = true,
      prefer_startup_root = true,

      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
        adaptive_size = true,
        preserve_window_proportions = true,
        -- float = {
        --   enable = true,
        --   open_win_config = open_win_config,
        -- },
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        group_empty = true,
        indent_markers = { enable = false },
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
