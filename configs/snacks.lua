require("snacks").setup({
	bigfile = {
		enabled = true,
		notify = true,
		size = 1.5 * 1024 * 1024, -- 1.5MB
	},
	explorer = { enabled = false },
	notifier = { enabled = true, timeout = 3000 },
	picker = {
		enabled = true,
		win = {
			input = {
				keys = {
					["<leader>h"] = { "toggle_hidden", mode = { "i", "n" } },
					["<leader>i"] = { "toggle_ignored", mode = { "i", "n" } },
				},
			},
		},
		sources = {
			files = {
				hidden = true,
			},
			explorer = {
				replace_netrw = false,
				auto_close = true,
				focus = "list",
				follow_file = true,
				layout = { preset = "sidebar", preview = false },
				win = {
					list = {
						keys = {
							["O"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
						},
					},
				},
			},
		},
	},
	scratch = {
		enabled = true,
		filekey = {
			cwd = true,
			branch = true,
			count = true,
		},
	},
	words = { enabled = true },
	gh = {
		enabled = true,
	},
})

vim.keymap.set({ "n", "t" }, "<leader>gP", function()
	Snacks.picker.gh_pr({ state = "open" })
end, { desc = "All Github Pull Requests" })
vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Toggle Explorer" })
vim.keymap.set("n", "<leader>ef", function()
	if Snacks.picker.get({ source = "explorer" })[1] == nil then
		Snacks.picker.explorer()
	elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == true then
		Snacks.picker.explorer()
	elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == false then
		Snacks.picker.get({ source = "explorer" })[1]:focus()
	end
end)
vim.keymap.set("n", "<leader>fs", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Find Grep" })
vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fp", function()
	Snacks.picker.git_files()
end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fbs", function()
	Snacks.picker.lines()
end, { desc = "Find Buffers Fuzzy" })
vim.keymap.set("n", "<leader>fgs", function()
	Snacks.picker.grep_word()
end, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch" })
vim.keymap.set("n", "<leader>ss", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch" })
vim.keymap.set({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })
vim.keymap.set("n", "<leader>nh", function()
	Snacks.notifier.show_history()
end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>ns", function()
	Snacks.picker.notifications()
end, { desc = "Show Notifications" })
vim.keymap.set("n", "<leader>nd", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })
vim.keymap.set("n", "<leader>sm", function()
	Snacks.picker.marks()
end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sr", function()
	Snacks.picker.registers()
end, { desc = "Registers" })
