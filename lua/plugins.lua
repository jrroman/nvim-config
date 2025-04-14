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

  use({ "rktjmp/lush.nvim" })

  -- colorschemes
  -- rose pine https://github.com/rose-pine/neovim
  -- use({ "rose-pine/neovim", name = "rose-pine", config = function() vim.cmd("colorscheme rose-pine") end })

  -- zenbones https://github.com/zenbones-theme/zenbones.nvim
  -- use({ "zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim", name = "tokyobones", config = function() vim.cmd("colorscheme tokyobones") end })

  use({
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    config = function()
      vim.g.gruvbox_material_background = "soft" -- hard, medium, soft
      vim.g.gruvbox_material_foreground = "original" -- original, mix, material
      vim.g.gruvbox_material_palette = "original" -- original, mix, material
      vim.g.gruvbox_material_enable_italic = 0 -- 0, 1
      vim.g.gruvbox_material_disable_italic_comment = 0 -- 0, 1
      vim.g.gruvbox_material_enable_bold = 0 -- 0, 1
      vim.g.gruvbox_material_transparent_background = 0 -- 0, 1, 2
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.cmd("colorscheme gruvbox-material") 
    end
  })

--  use({
--    "cocopon/iceberg.vim",
--    name = "iceberg",
--    config = function()
--      vim.g.iceberg_transparent = 1
--      vim.g.iceberg_enable_italic = 1
--      vim.g.iceberg_enable_bold = 1
--      vim.g.iceberg_enable_underline = 1
--      vim.g.iceberg_enable_inverse = 0
--      vim.g.iceberg_enable_cursorline = 0
--      vim.g.iceberg_enable_cursorcolumn = 0
--      vim.cmd("colorscheme iceberg")
--    end
--  })

  -- oscura https://github.com/vinitkumar/oscura-vim and  https://github.com/jwbaldwin/oscura.nvim
  -- use({ "vinitkumar/oscura-vim", config = function() vim.cmd("colorscheme oscura") end })

  -- poimandres https://github.com/olivercederborg/poimandres.nvim
  -- use({ "olivercederborg/poimandres.nvim", config = function() vim.cmd("colorscheme poimandres") end })

  -- tokyonight https://github.com/folke/tokyonight.nvim
  -- use({ "folke/tokyonight.nvim", config = function() vim.cmd("colorscheme tokyonight-night") end })

  -- nightowl https://github.com/haishanh/night-owl.vim
  -- use({ "haishanh/night-owl.vim", config = function() vim.cmd("colorscheme night-owl") end })

  -- monokai https://github.com/tanvirtin/monokai.nvim
  -- use({ "tanvirtin/monokai.nvim", config = get_config("monokai") })
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
