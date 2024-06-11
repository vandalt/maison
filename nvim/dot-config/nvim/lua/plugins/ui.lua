return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { section_separators = "", component_separators = "" },
      sections = {
        lualine_y = { "encoding", "fileformat" },
        lualine_z = {
          { "progress", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      -- Zen-mode will auto-activate twilight if installed
      "folke/twilight.nvim"
    }
  },
}
