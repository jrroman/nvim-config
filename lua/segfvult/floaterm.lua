local floaterm_state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

-- Create a floating window.
local function create_floating_window(opts)
  opts = opts or {}
  -- Calculate floating window size (80% width, 60% height).
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.6)

  -- Calculate the position of the floating window to center it.
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  -- Create the floating window.
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- Floating terminal user command.
vim.api.nvim_create_user_command("Floaterm", function()
  if not vim.api.nvim_win_is_valid(floaterm_state.floating.win) then
    floaterm_state.floating = create_floating_window { buf = floaterm_state.floating.buf }
    if vim.bo[floaterm_state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(floaterm_state.floating.win)
  end
end, {})

-- Setup keymap to toggle floating terminal.
vim.keymap.set("n", "<leader>ft", "<cmd>Floaterm<CR>", { silent = true })
