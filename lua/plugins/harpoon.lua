local harpoon = require("harpoon")

harpoon:setup()

local normalize_list = function(t)
  local normalized = {}
  for _, v in pairs(t) do
    if v ~= nil then
      table.insert(normalized, v)
    end
  end
  return normalized
end

local function toggle_snacks_picker(harpoon_files)
  Snacks.picker({
    finder = function()
      local file_paths = {}
      local list = normalize_list(harpoon_files.items)
      for i, item in ipairs(list) do
        table.insert(file_paths, { text = item.value, file = item.value })
      end
      return file_paths
    end,
    win = {
      input = {
        keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
      },
      list = {
        keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
      },
    },
    actions = {
      harpoon_delete = function(picker, item)
        local to_remove = item or picker:selected()
        harpoon_files:remove({ value = to_remove.text })
        harpoon_files.items = normalize_list(harpoon_files.items)
        picker:find({ refresh = true })
      end,
    },
  })
end

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end)
-- Classic harpoon list menu
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- Harpoon list menu with telescope, allows for fuzzy search
vim.keymap.set("n", "<leader>te", function()
  toggle_snacks_picker(harpoon:list())
end, { desc = "Open harpoon window" })
vim.keymap.set("n", "<leader>hc", function()
  harpoon:list():clear()
end)

vim.keymap.set("n", "<C-h>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-n>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-s>", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>hn", function()
  harpoon:list():next()
end)
