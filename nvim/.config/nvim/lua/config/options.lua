-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.clipboard = ""  -- Don't use system clipboard by deafult (see <leader>y in mappings)
opt.scrolloff = 2 -- Lines of context
opt.wrap = false -- Disable line wrap
vim.opt.smartindent = true
vim.g.python3_host_prog = "/usr/bin/python"

-- Hide dotfiles in netrw
vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"



vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      content = "text",
      priority = 0,
      selector = "textarea",
      takeover = "never",
    },
  },
}
