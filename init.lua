-- nvim tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- References to ./lua/
-- Defines all of our vim options
require("options")
-- Plugin management with Packer
require("plugins")
-- Key mappings
require("mappings")
-- Autocmd
require("autocmd")
--require("user-conf")
