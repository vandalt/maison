local function openSlimeTerm()
  local id = vim.fn.system("kitty @ launch --type=os-window --cwd=current")
  local new_config = { window_id = id, listen_on = "" }
  -- Make sure buffer from where new terminal is created gets updated
  vim.b.slime_config = new_config
  -- New buffers will use latest terminal by default
  vim.g.slime_default_config = new_config
end

local function updateSlimeDefaultConfig()
  vim.b.slime_config = vim.g.slime_default_config
end

local function openPythonREPL()
  openSlimeTerm()
  -- TODO: Check for venv otherwise do nothing
  vim.fn.system("kitty @ send-text 'pact; cd notebooks; ipython'\\\\x0D")
end

local function openJuliaREPL()
  openSlimeTerm()
  vim.fn.system("kitty @ send-text 'julia'\\\\x0D")
end

return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "kitty"
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_no_mappings = 1
      vim.g.slime_cell_delimiter = "# %%"
      -- TODO: Setup markdown as well
      -- vim.g.slime_cell_delimiter = "```"
      -- vim.g.slime_python_ipython = 1
      vim.g.slime_bracketed_paste = 1
      vim.keymap.set("n", "<leader>it", openSlimeTerm, { desc = "Open terminal for Slime" })
      vim.keymap.set("n", "<leader>ir", openPythonREPL, { desc = "Open IPython REPL" })
      vim.keymap.set("n", "<leader>ij", openJuliaREPL, { desc = "Open Julia REPL" })
      vim.keymap.set("n", "<leader>ic", "<Plug>SlimeConfig", { desc = "Set slime config" })
      vim.keymap.set("n", "<leader>iu", updateSlimeDefaultConfig, { desc = "Update slime config to latest default" })
      vim.keymap.set("n", "<leader>il", "<Plug>SlimeLineSend", { desc = "Send line to REPL" })
      vim.keymap.set("n", "<leader>is", "<Plug>SlimeMotionSend", { desc = "Send motion to REPL" })
      vim.keymap.set("x", "<leader>is", "<Plug>SlimeRegionSend", { desc = "Send selection to REPL" })
      vim.keymap.set("n", "<leader>ib", "<Plug>SlimeParagraphSend", { desc = "Send paragraph (block) to REPL" })
      vim.keymap.set("n", "<leader>ih", "<Plug>SlimeSendCell", { desc = "Send cell to REPL" })
      -- TODO: Proper dependency management for this mapping
      vim.keymap.set(
        "n",
        "<leader>ii",
        "<leader>ih]j",
        { remap = true, desc = "Send cell to REPL and go to the next" }
      )
    end,
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    -- Make sure toggleterm is installed to silence REPL warning
    dependencies = { "akinsho/toggleterm.nvim" },
    keys = {
      { "]j", function() require("notebook-navigator").move_cell "d" end },
      { "[j", function() require("notebook-navigator").move_cell "u" end },
    },
    event = "VeryLazy",
    config = true,
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
  },
}
