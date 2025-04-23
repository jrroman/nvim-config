local lspconfig = require("lspconfig")
local util      = require("lspconfig.util")
-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>ls', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>lS', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>lic', vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set('n', '<Leader>loc', vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, opts)
  end,
})

local go_on_attach = function(client, buffer)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=buffer }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
end

lspconfig.gopls.setup {
  cmd = {"gopls", "serve"},
  on_attach = go_on_attach,
  autostart = true,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

local clangd_on_attach = function(client, bufnr)
  -- your usual keymaps for hover, goto, etc.
  local buf_map = vim.api.nvim_buf_set_keymap
  local opts    = { noremap=true, silent=true, buffer=bufnr }

  buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_map(bufnr, "n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>",      opts)
  -- …and so on…
end,

lspconfig.clangd.setup{
  autostart = true,
  -- clangd run command
  cmd = {
    "clangd", 
    "--clang-tidy", 
    "--background-index", 
    "--suggest-missing-includes",
    "--completion-style=detailed",
  },

--  on_attach = clangd_on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
--  capabilities = {
--    {
--      offsetEncoding = { "utf-8", "utf-16" },
--      textDocument = {
--        completion = {
--          editsNearCursor = true
--        }
--      }
--    }
--  },
--
  -- How to detect your project root
  -- To generate "compile_commands.json" run the following from root of a repository:
  -- `bear -- make modules -j$(sysctl -n hw.ncpu)`
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", "build"),
--  root_markers = {
--    ".clangd",
--    ".clang-tidy",
--    ".clang-format",
--    "compile_commands.json",
--    "compile_flags.txt",
--    "configure.ac",
--    ".git",
--  },

  -- Which files to attach to
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
}

lspconfig.ts_ls.setup{
  autostart = true,
}

lspconfig.terraformls.setup{
  cmd = {"terraform-ls", "serve"},
  autostart = true,
  filetypes = {"terraform", "terraform-vars"},
}

local rust_on_attach = function(client, buffer)
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local rt = require("rust-tools")
rt.setup({
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = rust_on_attach,
    autostart = true,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
})

lspconfig.pyright.setup{
  cmd = {"pyright-langserver", "--stdio"},
  autostart = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      }
    },
    single_file_support = true,
  },
  filetypes = {"python"},
}

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

-- Configure LSP for bazel, still need to set this up. Might be able to just get
-- away with using vim-bazel https://github.com/bazelbuild/vim-bazel
-- --- ```lua
--- vim.filetype.add {
---   pattern = {
---     ['.*.bazelrc'] = 'bazelrc',
---   },
--- }
--- ```
-- cmd = { 'bazelrc-lsp', 'lsp' },
-- filetypes = { 'bazelrc' },
-- root_dir = util.root_pattern('WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel'),
-- root_markers = { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
