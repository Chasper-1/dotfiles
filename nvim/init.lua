-- Установка Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Загрузка всех плагинов из файла lua/plugins.lua
require("lazy").setup(require("plugins"))

-- Загрузка конфигов 
-- lua/
require("config")
require("keymap")
require("autocmd")

