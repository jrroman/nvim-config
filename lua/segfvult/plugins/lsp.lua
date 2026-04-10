local root_files = {
  ".luarc.json",
  ".luarc.jsonc",
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
  ".git",
}

--
return {
  "williamboman/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
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
    -- Completion capabilities
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- Progress indicator
    require("fidget").setup({})
    -- Mason & LSP installer
    require("mason").setup({
      PATH = "append",
      ui = {
        backdrop = 60,
      },
    })
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        -- "elixirls",
        "pyright",
        "gopls",
        "tailwindcss",
        "zls",
        "ts_ls",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { buffer = ev.buf }
        local border_style = "rounded"

        -- Pull my snacks bindings into my lsp attach to keep everthing lsp
        -- related in one place.
        vim.keymap.set("n", "<Leader>ld", function()
          Snacks.picker.lsp_definitions()
        end, opts)
        vim.keymap.set("n", "<Leader>lD", function()
          Snacks.picker.lsp_declarations()
        end, opts)
        vim.keymap.set("n", "<Leader>li", function()
          Snacks.picker.lsp_implementations()
        end, opts)
        vim.keymap.set("n", "<Leader>lt", function()
          Snacks.picker.lsp_type_definitions()
        end, opts)
        vim.keymap.set("n", "<Leader>lr", function()
          Snacks.picker.lsp_references()
        end, opts)
        vim.keymap.set("n", "<Leader>ls", function()
          Snacks.picker.lsp_symbols()
        end, opts)
        -- Hover and signature
        vim.keymap.set("n", "<Leader>lh", function()
          vim.lsp.buf.hover({ border = border_style })
        end, opts)
        vim.keymap.set("n", "<Leader>lS", function()
          vim.lsp.buf.signature_help({ border = border_style })
        end, opts)
        -- Calls
        vim.keymap.set("n", "<Leader>lic", vim.lsp.buf.incoming_calls, opts)
        vim.keymap.set("n", "<Leader>loc", vim.lsp.buf.outgoing_calls, opts)
        -- Workspace
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        -- Format
        vim.keymap.set({ "n", "v" }, "<Leader>f", function()
          require("conform").format({ bufnr = ev.buf })
        end, opts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
        end

        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

    -- C / C++
    vim.lsp.config("clangd", {
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed", -- bundled (default), detailed
      },
      filetypes = { "c", "cpp" },
      root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
      init_options = {
        fallbackFlags = {
          "-x",
          "c",
          "-std=c23",
          -- "-std=c++20",
        },
      },
    })
    vim.lsp.enable("clangd")

    -- Rust
    vim.lsp.config("rust_analyzer", {
      cmd = { "rust-analyzer" },
      cabilities = capabilities,
      filetypes = { "rust" },
      root_markers = { "Cargo.toml" },
      settings = {
        ["rust-analyzer"] = {
          inlayHints = {
            parameterHints = {
              enable = false,
            },
            typeHints = {
              enable = false,
            },
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            allFeatures = true,
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      },
    })

    -- Go
    local go_on_attach = function(client, buffer)
      vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
      local bufopts = { noremap = true, silent = true, buffer = buffer }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      -- add more mappings as needed
    end

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      cmd = { "gopls", "serve" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_markers = { "go.mod", "go.work", ".git" },
      on_attach = go_on_attach,
      autostart = true,
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
          completeUnimported = true,
          usePlaceholders = true,
        },
      },
    })

    -- Elixir
    vim.lsp.config("elixirls", {
      capabilities = capabilities,
      filetypes = { "elixir", "eelixir", "heex", "surface" },
      root_markers = { "mix.exs", ".git" },
      cmd = { "/Users/jr/workspace/scripts/elixir/language_server.sh" },
    })

    -- Zig
    vim.lsp.config("zls", {
      capabilities = capabilities,
      root_markers = { ".git", "build.zig", "zls.json" },
      settings = {
        zls = {
          enable_inlay_hints = true,
          enable_snippets = true,
          warn_style = true,
        },
      },
    })
    -- vim.g.zig_fmt_parse_errors = 0
    -- vim.g.zig_fmt_autosave      = 0

    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
        },
      },
    })

    -- TailwindCSS
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
      filetypes = {
        "html",
        "css",
        "scss",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              "tw`([^`]*)",
              'tw="([^"]*)',
              'tw={"([^"}]*)',
              "tw\\.\\w+`([^`]*)",
              "tw\\(.*?\\)`([^`]*)",
            },
          },
        },
      },
    })

    -- nvim-cmp setup
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-v>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
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
      virtual_text = false,
      float = {
        focusable = true,
        border = "rounded",
        header = false,
      },
    })
  end,
}
