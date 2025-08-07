return {
  'akinsho/bufferline.nvim',
  release = "v4.*",
  requires = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup({
      options = {
        numbers = "buffer_id",
      }
    })
  end
}
