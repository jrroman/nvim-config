return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gs", vim.cmd.Git, mode = "n" },
  },
  config = function()
    local segfvult_fugitive = vim.api.nvim_create_augroup("segfvult_fugitive", {})
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = segfvult_fugitive,
      pattern = "*",
      callback = function()
        -- If buffer filetype is not fugitive return
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}
        -- vim.keymap.set("n", "<leader>p", function()
        --   vim.cmd.Git('push')
        -- end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", ":Git pull --rebase origin ", opts);

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>pb", ":Git push -u origin ", opts);
      end,
    })
  end
}
