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
  use({ "wbthomason/packer.nvim" })

  -- lspconfig
  use({ "neovim/nvim-lspconfig" })

  use({ 'nvim-tree/nvim-web-devicons' })

  -- lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = get_config("lualine"),
  }

  -- bufferline
  use ({
    'akinsho/bufferline.nvim',
    tag = "v4.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = get_config("bufferline"),
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
  -- Snippet engine
    "hrsh7th/vim-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    config = get_config("cmp"),
  })

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
  use({
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = get_config("nvim-tree"),
  })

  -- golang support
  use({ "ray-x/go.nvim" })
  use({"ray-x/guihua.lua", run = "cd lua/fzy && make"})

  use({ "tpope/vim-fugitive" })

  -- elixir support
  use({ 
    "elixir-tools/elixir-tools.nvim",
    tag = "stable",
    requires = { "nvim-lua/plenary.nvim" },
    config = get_config("elixir-tools"),
  })

  use({ "rktjmp/lush.nvim" })

  -- Bazel support
  use({ "google/vim-maktaba" })
  use({
    "bazelbuild/vim-bazel",
    dependencies = {
      "google/vim-maktaba"
    },
  })

  -- colorschemes
  use({
    "jnurmine/Zenburn",
    name = "zenburn",
    config = function()
      vim.g.zenburn_high_Contrast = 0
      vim.g.zenburn_subdued_LineNr = 1
      vim.api.nvim_create_autocmd(
        { "VimEnter", "WinEnter" },
        {
          pattern = "*",
          command = "highlight Search ctermfg=230 ctermbg=22 guifg=#000000 guibg=#faf8f2",
        }
      )
      -- vim.cmd("colorscheme zenburn")
    end
  })

  -- Below are colorschemes that I have tried and liked but not using now.
  -- oscura https://github.com/vinitkumar/oscura-vim and  https://github.com/jwbaldwin/oscura.nvim
  -- use({ "vinitkumar/oscura-vim", config = function() vim.cmd("colorscheme oscura") end })

  -- poimandres https://github.com/olivercederborg/poimandres.nvim
  -- use({ "olivercederborg/poimandres.nvim", config = function() vim.cmd("colorscheme poimandres") end })

  -- tokyonight https://github.com/folke/tokyonight.nvim
  -- use({ "folke/tokyonight.nvim", config = function() vim.cmd("colorscheme tokyonight-night") end })

  -- gruvbox https://github.com/morhetz/gruvbox
  -- use({ "morhetz/gruvbox", config = function() vim.cmd("colorscheme gruvbox") end })

  -- nightowl https://github.com/haishanh/night-owl.vim
  -- use({ "haishanh/night-owl.vim", config = function() vim.cmd("colorscheme night-owl") end })

  -- monokai https://github.com/tanvirtin/monokai.nvim
  -- use({ "tanvirtin/monokai.nvim", config = get_config("monokai") })

  -- use({ "sainnhe/gruvbox-material",
  --   name = "gruvbox-material",
  --   config = function()
  --     vim.g.gruvbox_material_background = "soft" -- hard, medium, soft
  --     vim.g.gruvbox_material_foreground = "original" -- original, mix, material
  --     vim.g.gruvbox_material_palette = "original" -- original, mix, material
  --     vim.g.gruvbox_material_enable_italic = 0 -- 0, 1
  --     vim.g.gruvbox_material_disable_italic_comment = 0 -- 0, 1
  --     vim.g.gruvbox_material_enable_bold = 0 -- 0, 1
  --     vim.g.gruvbox_material_transparent_background = 0 -- 0, 1, 2
  --     vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
  --     vim.cmd("colorscheme gruvbox-material") 
  --   end
  -- })

  -- rose pine https://github.com/rose-pine/neovim
  use({
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end
  })

  -- zenbones https://github.com/zenbones-theme/zenbones.nvim
  -- use({ "zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim", name = "zenbones", config = function() vim.cmd("colorscheme zenburned") end })
end)

require("config/lsp")
require("config/treesitter")
require("go").setup()
require("go.format").goimport()
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

if packer_bootstrap then
  require("packer").sync()
  return
end
