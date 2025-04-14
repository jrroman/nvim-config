local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    -- Overrides
    custom_captures = {
      -- Highlight the @function capture group with the "Function" highlight group.
      -- ["function"] = "Function",
      -- ["method"] = "Function",
      -- ["variable"] = "Identifier",
      -- ["parameter"] = "Identifier",
    },
  },
  incremental_selection = {
    enable = true
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  playground = {
    enable = true,
  }
}
