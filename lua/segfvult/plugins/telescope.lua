return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>ff", ":Telescope find_files<CR>" },
    { "<leader>fg", ":Telescope live_grep<CR>" },
    { "<leader>fb", ":Telescope buffers<CR>" },
    { "<leader>fp", ":Telescope git_files<CR>" },
    { "<leader>fbs", ":Telescope current_buffer_fuzzy_find<CR>" },
    { "<leader>fgs", ":Telescope grep_string<CR>" },
    { "<leader>fh", ":Telescope help_tags<CR>" },
  },
  config = function()
    require('telescope').setup({})
  end
}
