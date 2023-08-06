local function run_py_file()
	-- TODO: probably a way to do this with toggleterm+lua
	-- TODO: Separate function to handle the "shellescape" part
	local myfn = vim.fn.expand("%"):gsub(" ", "\\\\ "):gsub("#", "\\\\#")
	vim.cmd([[:TermExec cmd="python ]] .. myfn .. [["<CR>]])
end

return {
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
      { "<leader>rk", "<cmd>ARsyncUpDelete<CR>", desc = "Push with rsync and delete files" },
      { "<leader>rd", "<cmd>ARsyncDown<CR>", desc = "Pull with rsync" },
    },
  },
  "tpope/vim-eunuch",
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
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = [[<C-\>]],
      start_in_insert = false,
    },
    keys = {
      {"<leader>pr", function() run_py_file() end, desc = "Run Python file in terminal" },
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
    "RRethy/vim-illuminate",
    -- enabled = false,
    -- keys = {
    --   { "]r", desc = "Next Reference" },
    --   { "[r", desc = "Prev Reference" },
    -- },
  },
}
