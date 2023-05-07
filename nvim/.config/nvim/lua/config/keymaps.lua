-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

Utils = require("utils")

Utils.map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
Utils.map("i", "<A-.>", "<C-v>u00b7", { desc = "Point median" })
Utils.map("i", "<A-d>", "📅", { desc = "Calendar icon" })
Utils.map("i", "<A-s>", "⏳", { desc = "Hourglass icon" })
Utils.map("i", "<A-u>", "μ", { desc = "greek letter mu" })
Utils.map("n", "<A-f>", ":setlocal spell! spelllang=fr<CR>", { desc = "Toggle FR spell checking"})
Utils.map("n", "<A-e>", ":setlocal spell! spelllang=en_ca<CR>", { desc = "Toggle english spell checking" })
Utils.map("n", "<leader>pr", ":lua require('utils').RunPyFile()<CR>", { desc="Run Python file in terminal" })
