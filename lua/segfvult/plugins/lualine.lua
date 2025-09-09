return {
  "nvim-lualine/lualine.nvim",
  requires = {
    "nvim-tree/nvim-web-devicons",
    opt = true,
  },
  config = function()
    function set_buf_name()
      local buftype = vim.bo.buftype
      vim.inspect(buftype)
      if buftype == "quickfix" then
        return "[Quickfix List]"
      elseif buftype == "loclist" then
        return "[Location List]"
      else
        return vim.fn.fnamemodify(vim.fn.bufname(), ":t")
      end
    end

    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = { right = "|" },
        section_separators = { right = "|" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            "WinEnter",
            "BufEnter",
            "BufWritePost",
            "SessionLoadPost",
            "FileChangedShellPost",
            "VimResized",
            "Filetype",
            "CursorMoved",
            "CursorMovedI",
            "ModeChanged",
          },
        }
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { set_buf_name },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { set_buf_name },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    })
  end
}
