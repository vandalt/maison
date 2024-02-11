local function run_py_file()
  -- TODO: probably a way to do this with toggleterm+lua
  -- TODO: Separate function to handle the "shellescape" part
  local myfn = vim.fn.expand("%"):gsub(" ", "\\\\ "):gsub("#", "\\\\#")
  vim.cmd([[:TermExec cmd="python ]] .. myfn .. [["<CR>]])
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- For browser
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      -- add a keymap to search without ignoring files
      {
        "<leader>si",
        function()
          require("telescope.builtin").find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
        end,
        desc = "Find File (Include ignored and hidden files)",
      },
      {
        "<leader>fB",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "Telescope file browser",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>z"] = { name = "+zk" },
        -- ["<leader>m"] = { name = "+markdown" },
        ["<leader>n"] = { name = "+neogen" },
        ["<leader>i"] = { name = "+ipython (REPLs)" },
      },
    },
  },
  {
    "KenN7/vim-arsync",
    dependencies = {
      "prabirshrestha/async.vim",
    },
    keys = {
      { "<leader>ru", "<cmd>ARsyncUp<CR>", desc = "Push with rsync" },
      { "<leader>rd", "<cmd>ARsyncUpDelete<CR>", desc = "Push with rsync and delete files" },
      { "<leader>rl", "<cmd>ARsyncDown<CR>", desc = "Pull with rsync" },
    },
  },
  "tpope/vim-eunuch",
  "tpope/vim-sleuth",
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cond = vim.fn.executable("gh"),
    config = true,
    -- config = function()
    --   require("octo").setup()
    -- end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<C-\>]],
      start_in_insert = false,
    },
    keys = {
      {
        "<leader>ct",
        function()
          run_py_file()
        end,
        desc = "Run Python file in terminal",
      },
    },
    lazy = false,
  },
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      disable_commit_confirmation = true,
    },
    keys = {
      { "<leader>gn", "<Cmd>Neogit<CR>", desc = "Open neogit window" },
    },
  },
  {
    "linrongbin16/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    -- opts = {
    --   mappings = nil,
    -- }
  },
  -- From https://www.lazyvim.org/plugins/editor#vim-illuminate
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]r", "next")
      map("[r", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]r", "next", buffer)
          map("[r", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]r", desc = "Next Reference" },
      { "[r", desc = "Prev Reference" },
    },
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- This keeps it pinned to semantic releases
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      -- This would be an optional dependency eventually
      "nvim-telescope/telescope.nvim",
    },
    config = true, -- This calls the default setup(); make sure to call it
  },
}
