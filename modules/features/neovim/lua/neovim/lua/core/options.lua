local opt = vim.opt

opt.relativenumber = true
opt.number = true
-- 4 spaces for tabs
opt.tabstop = 2
opt.shiftwidth = 2
-- Convert tabs to spaces.
opt.expandtab = true
opt.smartindent = true
-- True color support (works great with WezTerm)
opt.termguicolors = true
-- Sync with system clipboard
opt.clipboard = "unnamedplus"
