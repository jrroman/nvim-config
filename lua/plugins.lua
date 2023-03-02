local settings = require("user-conf")
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
  })

  -- terminal
  use({ 
    "numToStr/FTerm.nvim",
    config = function()
      get_config("fterm")
    end
  })

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

  -- golang support
  use("ray-x/go.nvim")
--  use("ray-x/guihua.nvim")

  use({ "tpope/vim-fugitive" })
  
  -- colorschemes
  use({
    "tanvirtin/monokai.nvim",
    config = get_config("monokai"),
  })
--  use({ 
--    "sainnhe/sonokai", 
--    config = get_config("sonokai") ,
--  })
--  use({ 
--    "EdenEast/nightfox.nvim",
--    config = get_config("nightfox") 
--  })
end)

require("config/lsp")
require("config/treesitter")
require("config/lualine")
require("go").setup()
require("go.format").goimport()
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
