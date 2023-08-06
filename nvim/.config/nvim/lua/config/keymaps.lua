-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+y$]])

vim.keymap.set("i", "<A-.>", "<C-v>u00b7", { desc = "Point médian" })
vim.keymap.set("i", "<A-d>", "📅", { desc = "Calendar icon" })
vim.keymap.set("i", "<A-s>", "⏳", { desc = "Hourglass icon" })
vim.keymap.set("i", "<A-u>", "μ", { desc = "greek letter mu" })
vim.keymap.set("n", "<A-f>", "<cmd>setlocal spell! spelllang=fr<CR>", { desc = "Toggle FR spell checking" })
vim.keymap.set("n", "<A-e>", "<cmd>setlocal spell! spelllang=en_ca<CR>", { desc = "Toggle english spell checking" })

-- Window size with control and without arrow keys
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Equalize windows" })
vim.keymap.set("n", "<C-,>", "<C-w><", { desc = "Increase window size horizontally" })
vim.keymap.set("n", "<C-.>", "<C-w>>", { desc = "Decrease window size horizontally" })
vim.keymap.set("n", "<C-=>", "<C-w>+", { desc = "Increase window size vertically" })
vim.keymap.set("n", "<C-->", "<C-w>-", { desc = "Decrease window size vertically" })

-- Start of line: Make 0 go to first non-blank character
vim.keymap.set("n", "0", "_", {})
vim.keymap.set("n", "^", "999h", {})
vim.keymap.set("n", "<leader>0", "^", { remap = true })

vim.keymap.set("n", "<leader>cw", "<Cmd>%s/\\s\\+$//e|norm!``<CR>", { desc = "Clear trailing spaces" })

local function cppath()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end

vim.api.nvim_create_user_command("Cppath", cppath, {})
vim.keymap.set("n", "<leader>cp", cppath, { desc = "Copy path to clipboard" })
