return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')
    -- Search for files in current directory
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    -- Search for files in buffers
    vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
    -- Search for files in git
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    -- Search words in current directory
    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    -- Search words in current buffer
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    -- Search words in all buffers
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    -- Search help tags
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
