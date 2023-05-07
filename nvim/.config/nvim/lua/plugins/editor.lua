return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
    }
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sc", false }
    }
  },

  {
    "TimUntersberger/neogit",
    dependencies = { "sindrets/diffview.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      integrations = {
              diffview = true,
      },
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<CR>", desc = "Open neogit" },
    }
  },

  { "tpope/vim-eunuch" },
  {
    "akinsho/nvim-toggleterm.lua",
    opts = {
      open_mapping = [[<A-\>]],
      start_in_insert = false,
    }
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>mm", "<cmd>MaximizerToggle!<CR>", desc = "Maximize current window" },
    }
  }
}
