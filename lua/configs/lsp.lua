local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

require("fidget").setup({})
require("mason").setup({
	PATH = "append",
	ui = { backdrop = 60 },
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }
		local border_style = "rounded"

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
		vim.keymap.set("n", "<Leader>lh", function()
			vim.lsp.buf.hover({ border = border_style })
		end, opts)
		vim.keymap.set("n", "<Leader>lS", function()
			vim.lsp.buf.signature_help({ border = border_style })
		end, opts)
		vim.keymap.set("n", "<Leader>lic", vim.lsp.buf.incoming_calls, opts)
		vim.keymap.set("n", "<Leader>loc", vim.lsp.buf.outgoing_calls, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

        -- Formatting
		vim.keymap.set({ "n", "v" }, "<Leader>f", function()
			require("conform").format({ bufnr = ev.buf })
		end, opts)

		-- Go-specific keymaps (previously in go_on_attach)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.name == "gopls" then
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		end

		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
		end

		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

-- C / C++
vim.lsp.config("clangd", {
	capabilities = capabilities,
	cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
	filetypes = { "c", "cpp" },
	root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
	init_options = {
		fallbackFlags = { "-x", "c", "-std=c23" },
	},
})
vim.lsp.enable("clangd")

-- Rust (note: was "cabilities" typo in your original)
vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml" },
	settings = {
		["rust-analyzer"] = {
			inlayHints = {
				parameterHints = { enable = false },
				typeHints = { enable = false },
			},
			imports = { granularity = { group = "module" }, prefix = "self" },
			cargo = { allFeatures = true, buildScripts = { enable = true } },
			procMacro = { enable = true },
		},
	},
})
vim.lsp.enable("rust_analyzer")

-- Go
vim.lsp.config("gopls", {
	capabilities = capabilities,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work", ".git" },
	settings = {
		gopls = {
			analyses = { unusedparams = true },
			staticcheck = true,
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
})
vim.lsp.enable("gopls")

-- Elixir
vim.lsp.config("elixirls", {
	capabilities = capabilities,
	filetypes = { "elixir", "eelixir", "heex", "surface" },
	root_markers = { "mix.exs", ".git" },
	cmd = { "/Users/jr/workspace/scripts/elixir/language_server.sh" },
})
vim.lsp.enable("elixirls")

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
vim.lsp.enable("zls")

-- Lua
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = { indent_style = "space", indent_size = "2" },
			},
		},
	},
})
vim.lsp.enable("lua_ls")

-- TailwindCSS
vim.lsp.config("tailwindcss", {
	capabilities = capabilities,
	filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue", "svelte" },
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
vim.lsp.enable("tailwindcss")

-- TypeScript
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})
vim.lsp.enable("ts_ls")

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

vim.diagnostic.config({
	virtual_text = false,
	float = {
		focusable = true,
		border = "rounded",
		header = false,
	},
})
