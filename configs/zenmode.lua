require("zen-mode").setup({
	window = {
		backdrop = 0.95,
		width = 180,
		height = 1,
		options = {},
	},
	plugins = {
		options = {
			enabled = true,
			ruler = false,
			showcmd = false,
			laststatus = 0,
		},
		twilight = { enabled = true },
		gitsigns = { enabled = false },
		tmux = { enabled = false },
		alacritty = {
			enabled = false,
			font = "14",
		},
	},
})

vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })
