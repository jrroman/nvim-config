local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local function get_config(name)
	  return string.format('require("config/%s")', name)
end

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing Packer...")
	vim.api.nvim_command("packadd packer.nvim")
end

-- configure packer
local packer = require("packer")

packer.init({
  enable = true, -- enables profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over
  -- limit number of simultaneous jobs, nil = no limit
  -- Set to 20 to avoid PackerSync being stuck https://github.com/wbthomason/packer.nvim/issues/746
  max_jobs = 20, 
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- lspconfig
  use("neovim/nvim-lspconfig")

  -- lualine
  use({
    "nvim-lualine/lualine.nvim",
    requires = { 
      "kyazdani42/nvim-web-devicons", 
      opt = true,
    },
    config = get_config("lualine"),
  })

  -- DAP (debug adapter protocol) and supporting components
  use({ "nvim-neotest/nvim-nio" })
  use({ "mfussenegger/nvim-dap" })
  use({ 
    "theHamsta/nvim-dap-virtual-text",
    config = get_config("dap-virtual-text"),
  })
  use({ 
    "rcarriga/nvim-dap-ui", 
    requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = get_config("dap-ui"),
  })

  -- Code completion
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  -- Snippet engine
  use('hrsh7th/vim-vsnip')

  -- rust
  use("simrat39/rust-tools.nvim")

  -- telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = get_config("telescope"),
  })
  use({ "crispgm/telescope-heading.nvim" })
  use({ "nvim-telescope/telescope-packer.nvim" })
  use({ 
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make" 
  })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })

  -- treesitter
  use({ 
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  })
  use({ "nvim-treesitter/playground" })

  -- nvim tree
  -- use({ "nvim-tree/nvim-tree.lua" })

  -- golang support
  use({ "ray-x/go.nvim" })
  use({"ray-x/guihua.lua", run = "cd lua/fzy && make"})

  use({ "tpope/vim-fugitive" })

  -- elixir support
  use({ 
      "elixir-tools/elixir-tools.nvim",
      tag = "stable",
      requires = { "nvim-lua/plenary.nvim",
  }})

  -- colorschemes
  use({
      "tanvirtin/monokai.nvim",
      config = get_config("monokai"),
  })
end)

require("config/lsp")
require("config/treesitter")
-- require("config/nvim-tree")
require("go").setup()
require("go.format").goimport()
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
require("elixir")

if packer_bootstrap then
  require("packer").sync()
  return
end
