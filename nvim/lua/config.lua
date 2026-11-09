-- Установка базовых опций Vim
--vim.opt.linebreak = true      -- Перенос слов, вместо символов
vim.opt.nu = true             -- Номера строк
vim.opt.relativenumber = true -- Относительные номера строк
vim.opt.tabstop = 4           -- Табуляция в 4 пробела
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 180
vim.opt.colorcolumn = "120"
vim.opt.listchars = "tab: ,multispace:|   ,eol:󰌑" -- Показывает скрытые символы
vim.opt.winborder = "rounded"
vim.opt.expandtab = true      -- Замена табуляции пробелами
vim.opt.smartindent = true
vim.opt.termguicolors = true  -- Включить 24-битный цвет
vim.opt.scrolloff = 8         -- Минимум 8 строк вокруг курсора
vim.opt.clipboard = 'unnamedplus'

vim.g.mapleader = " "

-- *** КРИТИЧЕСКИ ВАЖНО для Мыши ***
vim.opt.mouse = 'a'           -- Включить поддержку мыши



