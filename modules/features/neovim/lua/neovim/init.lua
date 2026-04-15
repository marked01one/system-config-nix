require('core.options')
require('core.keymaps')

-- Setup lazy.nvim for plugin management.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This tells lazy to look in `lua/plugins/` for files
require("lazy").setup("plugins")
