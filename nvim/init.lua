-- Установка базовых опций Vim
vim.opt.nu = true            -- Номера строк
vim.opt.relativenumber = true -- Относительные номера строк
vim.opt.tabstop = 4          -- Табуляция в 4 пробела
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true     -- Замена табуляции пробелами
vim.opt.smartindent = true
vim.opt.termguicolors = true -- Включить 24-битный цвет
vim.opt.scrolloff = 8        -- Минимум 8 строк вокруг курсора
vim.opt.clipboard = 'unnamedplus'

-- *** КРИТИЧЕСКИ ВАЖНО для Мыши ***
vim.opt.mouse = 'a'          -- Включить поддержку мыши

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

-- Загрузка всех плагинов из файла lua/config/plugins.lua
require("lazy").setup(require("config.plugins"))
