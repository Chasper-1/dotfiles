
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>")
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>")  -- убрать подсветку по Escape
vim.keymap.set("n", "<leader>f", "<cmd>Telescope live_grep<CR>") -- Крутой поиск
vim.keymap.set('v', '<leader>,', "<cmd>exec 'Telescope grep_string default_text='<cr>", { desc = 'Find by Grep (Visual)' })
vim.keymap.set('n', '<leader>c', "<cmd>cclose<CR>") -- Убрать после Telescope ctrl + q вывод
