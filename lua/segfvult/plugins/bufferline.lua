return {
  'akinsho/bufferline.nvim',
  release = "v4.*",
  requires = 'nvim-tree/nvim-web-devicons',
  config = function()
    local rp_highlights = require("rose-pine.plugins.bufferline");
    require('bufferline').setup({
      highlights = rp_highlights,
      options = {
        numbers = "buffer_id",
      }
    })
  end
}
