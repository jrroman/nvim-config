return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    bigfile = {
      enabled = true,
      notify = true,
      size = 1.5 * 1024 * 1024, -- 1.5MB
    },
    explorer = { enabled = true, replace_netrw = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = { enabled = true },
    scratch = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Toggle Explorer",
    },
    {
      "<leader>ef",
      function()
        Snacks.explorer.reveal()
      end,
      desc = "Reveal Explorer",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Find Grep",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fbs",
      function()
        Snacks.picker.lines()
      end,
      desc = "Find Buffers Fuzzy",
    },
    {
      "<leader>fgs",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Find word under cursor",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Find Help Tags",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch",
    },
    {
      "<leader>ss",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "<leader>nh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
  },
}
