return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    require("orgmode").setup({
      org_agenda_files = "~/Documents/orgfiles/**/*",
      org_default_notes_file = "~/Documents/orgfiles/refile.org",
    })
  end,
}
