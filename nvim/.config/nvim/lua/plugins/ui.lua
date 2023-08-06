return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_y = { "encoding", "fileformat" },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      local custom_buttons = {
        dashboard.button("v", "󱓟" .. " LazyVim directory", ":e $HOME/.local/share/nvim/lazy/LazyVim/README.md <CR>"),
        dashboard.button("z", "" .. " Go to notes", ":cd $HOME/notes <CR> :e index.md <CR>"),
        -- dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(custom_buttons) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
        table.insert(dashboard.section.buttons.val, 5, button)
      end
    end,
    keys = {
      { "<leader>hh", "<cmd>Alpha<CR>", desc = "[H]ead to [h]ome screen" },
    },
  },
}
