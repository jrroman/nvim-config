require("vim._core.ui2").enable({})

require("options")
require("mappings")
require("autocmds")
require("floaterm")

vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/jrroman/plenary.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/leoluz/nvim-dap-go",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/tpope/vim-fugitive",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  { src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0" },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/wincent/base16-nvim",
  "https://github.com/folke/zen-mode.nvim",
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/toppair/peek.nvim",
  "https://github.com/stevearc/oil.nvim",
})

vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

require("configs.bufferline")
require("configs.colors")
require("configs.conform")
require("configs.dap")
require("configs.snacks")
-- to avoid import conflicts call harpoon harpon...
require("configs.harpoon")
require("configs.lsp")
require("configs.lualine")
require("configs.oil")
require("configs.snippets")
require("configs.supermaven")
require("configs.treesitter")
require("configs.trouble")
require("configs.whichkey")
require("configs.zenmode")

local function pack_clean()
  local unused = {}
  for _, plugin in ipairs(vim.pack.get()) do
    if not plugin.active then
      table.insert(unused, plugin.spec.name)
    end
  end
  if #unused == 0 then
    print("No unused plugins.")
    return
  end
  local choice = vim.fn.confirm("Remove " .. #unused .. " unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused)
  end
end

vim.keymap.set("n", "<leader>px", pack_clean, { desc = "Pack: Clean unused" })
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Pack update" })
