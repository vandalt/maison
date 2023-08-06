return {
  {
    "catppuccin/nvim",
    name="catppuccin",
    opts = {
      integrations = {
        illuminate = true,
      }
    }
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    }
  },
}
