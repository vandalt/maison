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
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local custom_center = {
        {
          action = ":e $HOME/.local/share/nvim/lazy/LazyVim/README.md",
          desc = " LazyVim directory",
          icon = "󱓟",
          key = "v",

        },
        {
          action = function()
            vim.cmd("cd $HOME/notes")
            vim.cmd(":e index.md")
          end,
          desc = " Go to notes",
          icon = "",
          key = "z",

        }
      }

      for _, button in ipairs(custom_center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
        table.insert(opts.config.center, 5, button)
      end
    end
  },
  -- { "dressing.nvim", enabled = false },
  -- {
  --   "3rd/image.nvim",
  --   config = true,
  --   opts = {
  --     backend = "kitty", -- whatever backend you would like to use
  --     max_width = 100,
  --     max_height = 12,
  --     max_height_window_percentage = math.huge,
  --     max_width_window_percentage = math.huge,
  --     window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
  --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --   },
  -- },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        command_palette = false,
      },
      cmdline = {
        view = "cmdline",
      },
      -- popupmenu = {
      --   enabled = false,
      --   backend="cmp",
      -- }
    }
  },
  -- {
  --   "goolord/alpha-nvim",
  --   opts = function(_, dashboard)
  --     local custom_buttons = {
  --       dashboard.button("v", "󱓟" .. " LazyVim directory", ":e $HOME/.local/share/nvim/lazy/LazyVim/README.md <CR>"),
  --       dashboard.button("z", "" .. " Go to notes", ":cd $HOME/notes <CR> :e index.md <CR>"),
  --       -- dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  --     }
  --     for _, button in ipairs(custom_buttons) do
  --       button.opts.hl = "AlphaButtons"
  --       button.opts.hl_shortcut = "AlphaShortcut"
  --       table.insert(dashboard.section.buttons.val, 5, button)
  --     end
  --   end,
  --   keys = {
  --     { "<leader>hh", "<cmd>Alpha<CR>", desc = "[H]ead to [h]ome screen" },
  --   },
  -- },
}
