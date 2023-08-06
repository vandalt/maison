-- local function iron_open_below()
--   local iron = require("iron")
--   local old_config = iron.config.repl_open_cmd
--   iron.config.repl_open_cmd = require("iron.view").split.botright("30%")
--   iron.core.repl_for(vim.api.nvim_buf_get_option(0,"ft"))
--   iron.config.repl_open_cmd = old_config
-- end

local function openSlimeTerm()
  local id = vim.fn.system("kitty @ launch --type=os-window --cwd=current")
  vim.b.slime_config = { window_id = id, listen_on = "" }
end

local function openREPL()
  openSlimeTerm()
  -- TODO: Check for venv otherwise do nothing
  vim.fn.system("kitty @ send-text 'pact; ipython'\\\\x0D")
  vim.fn.system("hyprctl dispatch focuscurrentorlast")
end

return {
  {
    "kiyoon/jupynium.nvim",
    opts = {
      use_default_keybindings = false,
      textobjects = { use_default_keybindings = false },
      python_host = vim.fn.expand("~/.local/pipx/venvs/jupynium/bin/python"),
      firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
      firefox_profile_name = "selprofile",
      jupynium_file_pattern = { "*.ju.*", "*.ipynb", ".py" },
    },
    lazy = false,
    keys = {
      -- Execution keybindings
      {
        "<leader>jj",
        "<cmd>JupyniumExecuteSelectedCells<CR>]j",
        desc = "Jupynium execute cell and go to next",
        remap = true,
      },
      { "<leader>jx", "<cmd>JupyniumExecuteSelectedCells<CR>", { "n", "x" }, desc = "Jupynium execute selected cell" },
      {
        "<leader>jc",
        "<cmd>JupyniumClearSelectedCellOutputs<CR>",
        { "n", "x" },
        desc = "Jupynium clear selected cells",
      },
      { "<leader>jk", "<cmd>JupyniumKernelHover<CR>", desc = "Jupynium hover (inspect a variable)" },
      { "<leader>jK", "<cmd>JupyniumKernelSelect<CR>", desc = "Jupynium select kernel" },
      { "<leader>js", "<cmd>JupyniumScrollToCell<CR>", { "n", "x" }, desc = "Jupynium scroll to cell" },
      {
        "<leader>jo",
        "<cmd>JupyniumToggleSelectedCellsOutputsScroll<CR>",
        { "n", "x" },
        desc = "Jupynium toggle selected cell output scroll",
      },
      { "<leader>jss", "<cmd>JupyniumStartAndAttachToServer<CR>", desc = "Jupynium start and attach to server" },
      {
        "<leader>jst",
        "<cmd>JupyniumStartAndAttachToServerInTerminal<CR>",
        desc = "Jupynium start and attach to server with terminal",
      },
      { "<leader>jsa", "<cmd>JupyniumAttachToServer<CR>", desc = "Jupynium attach to server" },
      { "<leader>jy", "<cmd>JupyniumStartSync<CR>", desc = "Jupynium start sync" },
      { "<PageUp>", "<cmd>JupyniumScrollUp<CR>", desc = "Jupynium scroll up" },
      { "<PageDown>", "<cmd>JupyniumScrollDown<CR>", desc = "Jupynium scroll down" },
      -- Textobject keybindings (mostly default expect for space)
      {
        "[j",
        "<cmd>lua require'jupynium.textobj'.goto_previous_cell_separator()<cr>",
        mode = { "n", "x", "o" },
        desc = "Go to previous Jupynium cell",
      },
      {
        "]j",
        "<cmd>lua require'jupynium.textobj'.goto_next_cell_separator()<cr>",
        mode = { "n", "x", "o" },
        desc = "Go to next Jupynium cell",
      },
      {
        "<space>jh",
        "<cmd>lua require'jupynium.textobj'.goto_current_cell_separator()<cr>",
        mode = { "n", "x", "o" },
        desc = "Go to current Jupynium cell",
      },
      {
        "aj",
        "<cmd>lua require'jupynium.textobj'.select_cell(true, false)<cr>",
        mode = { "x", "o" },
        desc = "Select around Jupynium cell",
      },
      {
        "ij",
        "<cmd>lua require'jupynium.textobj'.select_cell(false, false)<cr>",
        mode = { "x", "o" },
        desc = "Select inside Jupynium cell",
      },
      {
        "aJ",
        "<cmd>lua require'jupynium.textobj'.select_cell(true, true)<cr>",
        mode = { "x", "o" },
        desc = "Select around Jupynium cell (include next cell separator)",
      },
      {
        "iJ",
        "<cmd>lua require'jupynium.textobj'.select_cell(false, true)<cr>",
        mode = { "x", "o" },
        desc = "Select inside Jupynium cell (include next cell separator)",
      },
    },
    build = "pipx install --force .",
    dev = false,
  },
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "kitty"
      vim.g.slime_no_mappings = 1
      vim.g.slime_cell_delimiter = "# %%"
      vim.g.slime_python_ipython = 1
      vim.keymap.set("n", "<leader>it", openSlimeTerm, { desc = "Open terminal for Slime" })
      vim.keymap.set("n", "<leader>ir", openREPL, { desc = "Open IPython REPL" })
      vim.keymap.set("n", "<leader>il", "<Plug>SlimeLineSend", { desc = "Send line to REPL" })
      vim.keymap.set("n", "<leader>is", "<Plug>SlimeMotionSend", {desc = "Send motion to REPL" })
      vim.keymap.set("x", "<leader>is", "<Plug>SlimeRegionSend", {desc = "Send selection to REPL" })
      vim.keymap.set("n", "<leader>ib", "<Plug>SlimeParagraphSend", {desc = "Send paragraph (block) to REPL" })
      vim.keymap.set("n", "<leader>ii", "<leader>isajj]j", {remap = true, desc = "Send cell to REPL and go to the next" })
      vim.keymap.set("n", "<leader>ih", "<Plug>SlimeSendCell", {desc = "Send cell to REPL" })
    end,
  },
  -- {
  --   'luk400/vim-jukit',
  --   init = function()
  --     vim.g.jukit_termainl = "kitty"
  --     vim.g.jukit_output_new_os_window = 1
  --     vim.g.jukit_outhist_new_os_window = 1
  --   end
  -- },
  -- {
  --   "hkupty/iron.nvim",
  --   name = "iron",
  --   -- lazy = ,
  --   -- TODO: These will conflict with jupynium
  --   dependencies = {
  --     {
  --       "GCBallesteros/vim-textobj-hydrogen",
  --       dev = true,
  --       dependencies = {
  --         "kana/vim-textobj-user",
  --       }
  --     },
  --   },
  --   opts = function()
  --     return {
  --       config = {
  --         highlight_last = false,
  --         repl_definition = {
  --           python = require("iron.fts.python").ipython,
  --         },
  --         repl_open_cmd = require("iron.view").split.vertical("40%"),
  --       },
  --       keymaps = {
  --         send_motion = "<leader>is",
  --         visual_send = "<leader>is",
  --         send_line = "<leader>il",
  --         cr = "<leader>i<cr>",
  --         interrupt = "<leader>ik",
  --         exit = "<leader>iq",
  --         clear = "<leader>ic",
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     require("iron.core").setup(opts)
  --   end,
  --   keys = {
  --     { "<leader>ir", "<cmd>IronRepl<CR>", desc = "Toggle Iron REPL" },
  --     { "<leader>ib", iron_open_below, desc = "Toggle Iron REPL below" },
  --     { "<leader>is", "<cmd>IronRestart<CR>", desc = "Restart Iron REPL" },
  --     { "<leader>if", "<cmd>IronFocus<CR>", desc = "Focus Iron REPL" },
  --     { "<leader>ii", "<leader>isajj]j", desc = "Run cell and go to next", remap = true },
  --     { "<leader>ih", "<leader>isaj", desc = "Run cell", remap = true },
  --   },
  -- },
}
