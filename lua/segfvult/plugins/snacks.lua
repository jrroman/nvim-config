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
    explorer = { enabled = false },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          replace_netrw = false,
          auto_close = true,
          focus = "list",
          follow_file = true,
          layout = { preset = "sidebar", preview = false },
          win = {
            list = {
              keys = {
                ["O"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
    scratch = {
      enabled = true,
      filekey = {
        cwd = true,
        branch = true,
        count = true,
      },
    },
    words = { enabled = true },
    gh = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({ state = "open" })
      end,
      desc = "All Github Pull Requests",
      mode = { "n", "t" },
    },
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
        if Snacks.picker.get({ source = "explorer" })[1] == nil then
          Snacks.picker.explorer()
        elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == true then
          Snacks.picker.explorer()
        elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == false then
          Snacks.picker.get({ source = "explorer" })[1]:focus()
        end
      end,
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
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
      "<leader>ns",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Show Notifications",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
  },
}
