return {
  'akinsho/bufferline.nvim',
  release = "v4.*",
  requires = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup({
      highlights = {
        fill = {
          fg = "NONE",
          bg = "NONE",
        },
        background = {
          fg = "NONE",
          bg = "NONE",
        },
        tab = {
          fg = "NONE",
          bg = "NONE",
        },
      },
      options = {
        style_preset = 'minimal',
        numbers = "buffer_id",
      }
    })
  end
}
