local function configtreesitter()
  require('nvim-treesitter').setup({
    install_dir = vim.fn.stdpath('data') .. '/site'
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = configtreesitter
}
