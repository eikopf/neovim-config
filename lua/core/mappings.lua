require('core.lazy') -- init plugins so we can create mappings

vim.g.mapleader = " " -- map <leader> to spacebar
vim.keymap.set("n", "-", vim.cmd.Ex) -- req. nvim 0.8+

-- telescope config
local tbuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>.', tbuiltin.find_files, { desc = "Search files in CWD" })
vim.keymap.set('n', '<leader>,', tbuiltin.buffers, { desc = "Search active buffers" })
vim.keymap.set('n', '<leader>sh', tbuiltin.help_tags, { desc = "[S]earch [H]elp" }) 
vim.keymap.set('n', '<leader>sg', tbuiltin.live_grep, { desc = "[S]earch with [G]rep" }) 
vim.keymap.set('n', '<leader>sc', tbuiltin.commands, { desc = "[S]earch [C]ommands" })
vim.keymap.set('n', '<leader>sd', tbuiltin.diagnostics, { desc = "[S]earch [D]iagnostics" })
