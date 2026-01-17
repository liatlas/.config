local map = vim.keymap.set
map("v", "<C-c>", '"+y')
map("n", "<Leader>w", ":w<CR>")
map("n", "<Leader>q", ":q<CR>")
map("i", "jkj", "<C-[>")
map("n", "<Leader>rp", ":term python %<CR>")

local builtin = require('telescope.builtin')
map('n', '<Leader>ff', builtin.find_files, { desc = "Telescope find files" })
map('n', '<Leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
map('n', '<Leader>fd', builtin.diagnostics, { desc = "Telescope diagnostics" })
map('n', '<Leader>sk', builtin.keymaps, { desc = "Telescope keymaps" })


