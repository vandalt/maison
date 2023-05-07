-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

Utils = require("utils")

local function augroup(name)
  return vim.api.nvim_create_augroup("tv_" .. name, { clear = true })
end

-- Don't indent in markdown files (weird behaviour in lists)
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("move_noindent"),
  pattern = { "markdown" },
  callback = function()
    -- vim.keymap.set("n", "q", "<cmd>close<cr>", {})
    Utils.map("n", "<A-j>", "<cmd>m .+1<cr>", { desc = "Move down" })
    Utils.map("n", "<A-k>", "<cmd>m .-2<cr>", { desc = "Move up" })
    Utils.map("i", "<A-j>", "<esc><cmd>m .+1<cr>gi", { desc = "Move down" })
    Utils.map("i", "<A-k>", "<esc><cmd>m .-2<cr>gi", { desc = "Move up" })
    Utils.map("v", "<A-j>", ":m '>+1<cr>", { desc = "Move down" })
    Utils.map("v", "<A-k>", ":m '<-2<cr>", { desc = "Move up" })
  end,
})
