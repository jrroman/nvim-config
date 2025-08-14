local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local util = lspconfig.util

    -- Optional formatter setup
    require("conform").setup({
      formatters_by_ft = {
        -- lua = { "stylua" },
        -- javascript = { "prettier" },
      },
    })

    -- Completion capabilities
    local cmp      = require("cmp")
    local cmp_lsp  = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- Progress indicator
    require("fidget").setup({})
    -- Mason & LSP installer
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "elixirls",
        "gopls",
        "tailwindcss",
        "zls",
      },
      handlers = {
        -- Default handler for all servers
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,

        -- Rust
        ["rust_analyzer"] = function()
          lspconfig.rust_analyzer.setup {
            capabilities = capabilities,
            cmd          = { "rust-analyzer" },
            filetypes    = { "rust" },
            root_dir     = util.root_pattern("Cargo.toml"),
            on_attach = function(client, bufnr)
              require("completion").on_attach(client)
              vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end,
            settings = {
              ["rust-analyzer"] = {
                imports = {
                  granularity = {
                    group = "module",
                  },
                  prefix = "self",
                },
                cargo = {
                  buildScripts = {
                    enable = true,
                  },
                },
                procMacro = {
                  enable = true,
                },
              }
            }
          }
        end,

        -- Go
        ["gopls"] = function()
          local go_on_attach = function(client, buffer)
            vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            local bufopts = { noremap = true, silent = true, buffer = buffer }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition,  bufopts)
            -- add more mappings as needed
          end

          lspconfig.gopls.setup {
            capabilities = capabilities,
            cmd          = { "gopls", "serve" },
            filetypes    = { "go", "gomod", "gowork", "gotmpl" },
            root_dir     = util.root_pattern("go.mod", "go.work", ".git"),
            on_attach    = go_on_attach,
            autostart    = true,
            settings = {
              gopls = {
                analyses           = { unusedparams = true },
                staticcheck        = true,
                completeUnimported = true,
                usePlaceholders    = true,
              },
            },
          }
        end,

        -- Elixir
        ["elixirls"] = function()
          lspconfig.elixirls.setup {
            capabilities = capabilities,
            filetypes    = { "elixir", "eelixir", "heex", "surface" },
            root_dir     = util.root_pattern("mix.exs", ".git") or vim.loop.os_homedir(),
            cmd          = { "/Users/jr/workspace/scripts/elixir/language_server.sh" },
          }
        end,

        -- Zig
        ["zls"] = function()
          lspconfig.zls.setup {
            capabilities = capabilities,
            root_dir     = util.root_pattern(".git", "build.zig", "zls.json"),
            settings     = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets    = true,
                warn_style         = true,
              },
            },
          }
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave      = 0
        end,

        -- Lua
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings     = {
              Lua = {
                format = {
                  enable        = true,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size  = "2",
                  },
                },
              },
            },
          }
        end,

        -- TailwindCSS
        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup {
            capabilities = capabilities,
            filetypes    = {
              "html", "css", "scss",
              "javascript", "javascriptreact",
              "typescript", "typescriptreact",
              "vue", "svelte",
            },
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    "tw`([^`]*)",
                    "tw=\"([^\"]*)",
                    "tw={\"([^\"}]*)",
                    "tw\\.\\w+`([^`]*)",
                    "tw\\(.*?\\)`([^`]*)",
                  },
                },
              },
            },
          }
        end,
      },
    })

    -- nvim-cmp setup
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"]    = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"]    = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"]    = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
          { name = "buffer" },
        }),
    })

    -- Diagnostics
    vim.diagnostic.config({
      float = {
        focusable = false,
        style     = "minimal",
        border    = "rounded",
        source    = "always",
        header    = "",
        prefix    = "",
      },
    })
  end,
}

