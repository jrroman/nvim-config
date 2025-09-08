return {
  'akinsho/bufferline.nvim',
  release = "v4.*",
  requires = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require('bufferline');
    bufferline.setup({
      options = {
        style_preset = bufferline.style_preset.minimal,
        numbers = "buffer_id",
        themable = false,
      }
    })
  end
}
