return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    -- function to open orgmode in a floating window. I could maybe leverage my
    -- exisiting function i use for my floating terminal.
    win_split_mode = function(name)
      -- Make sure it's not a scratch buffer by passing false as 2nd argument
      local bufnr = vim.api.nvim_create_buf(false, false)
      --- Setting buffer name is required
      vim.api.nvim_buf_set_name(bufnr, name)

      local fill = 0.8
      local width = math.floor((vim.o.columns * fill))
      local height = math.floor((vim.o.lines * fill))
      local row = math.floor((((vim.o.lines - height) / 2) - 1))
      local col = math.floor(((vim.o.columns - width) / 2))

      vim.api.nvim_open_win(bufnr, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded"
      })
    end

    require("orgmode").setup({
      org_agenda_files = { "~/Documents/orgfiles/**/*" },
      org_default_notes_file = "~/Documents/orgfiles/refile.org",
      win_split_mode = win_split_mode,
    })
  end,
}
