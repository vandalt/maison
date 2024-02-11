-- local function iron_open_below()
--   local iron = require("iron")
--   local old_config = iron.config.repl_open_cmd
--   iron.config.repl_open_cmd = require("iron.view").split.botright("30%")
--   iron.core.repl_for(vim.api.nvim_buf_get_option(0,"ft"))
--   iron.config.repl_open_cmd = old_config
-- end

local function openSlimeTerm()
  local id = vim.fn.system("kitty @ launch --type=os-window --cwd=current")
  local new_config = { window_id = id, listen_on = "" }
  -- Make sure buffer from where new terminal is created gets updated
  vim.b.slime_config = new_config
  -- New buffes will use latest terminal by default
  vim.g.slime_default_config = new_config
end

local function updateSlimeDefaultConfig()
  vim.b.slime_config = vim.g.slime_default_config
end

local function openPythonREPL()
  openSlimeTerm()
  -- TODO: Check for venv otherwise do nothing
  vim.fn.system("kitty @ send-text 'pact; cd notebooks; ipython'\\\\x0D")
  -- vim.fn.system("hyprctl dispatch focuscurrentorlast")
end

local function openJuliaREPL()
  openSlimeTerm()
  vim.fn.system("kitty @ send-text 'julia'\\\\x0D")
  -- vim.fn.system("hyprctl dispatch focuscurrentorlast")
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
    enabled = true,
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
        desc = "Go to current Jupyniu cell",
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
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_no_mappings = 1
      vim.g.slime_cell_delimiter = "# %%"
      -- TODO: For markdown
      -- vim.g.slime_cell_delimiter = "```"
      -- vim.g.slime_python_ipython = 1
      vim.g.slime_bracketed_paste = 1
      vim.keymap.set("n", "<leader>it", openSlimeTerm, { desc = "Open terminal for Slime" })
      vim.keymap.set("n", "<leader>ir", openPythonREPL, { desc = "Open IPython REPL" })
      vim.keymap.set("n", "<leader>ij", openJuliaREPL, { desc = "Open Julia REPL" })
      vim.keymap.set("n", "<leader>iu", updateSlimeDefaultConfig, { desc = "Update slime config to latest default" })
      vim.keymap.set("n", "<leader>il", "<Plug>SlimeLineSend", { desc = "Send line to REPL" })
      vim.keymap.set("n", "<leader>is", "<Plug>SlimeMotionSend", { desc = "Send motion to REPL" })
      vim.keymap.set("x", "<leader>is", "<Plug>SlimeRegionSend", { desc = "Send selection to REPL" })
      vim.keymap.set("n", "<leader>ib", "<Plug>SlimeParagraphSend", { desc = "Send paragraph (block) to REPL" })
      vim.keymap.set(
        "n",
        "<leader>ii",
        "<leader>isajj]j",
        { remap = true, desc = "Send cell to REPL and go to the next" }
      )
      vim.keymap.set(
        "n",
        "<leader>ic",
        "<leader>isio",
        { remap = true, desc = "Send markdown code cell to REPL" }
      )
      vim.keymap.set("n", "<leader>ih", "<Plug>SlimeSendCell", { desc = "Send cell to REPL" })
    end,
  },
  {
    "goerz/jupytext.vim",
    init = function()
      vim.g.jupytext_fmt = "py:percent"
    end,
  },
  -- {
  --   "benlubas/molten-nvim",
  --   build = ":UpdateRemotePlugins",
  --   init = function()
  --     vim.g.molten_image_provider = "image.nvim"
  --     vim.g.molten_output_win_max_height = 12
  --   end,
  -- },
  {
    "benlubas/molten-nvim",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      -- Probably a good idea to set a binding for `:noautocmd MoltenEnterOutput`
      vim.g.molten_auto_open_output = false
      -- Optional, nice for virtual text
      vim.g.molten_wrap_output = true
      -- Virtual text output
      vim.g.molten_virt_text_output = true
      -- Make output show up after ``` s.t. can add text to cell
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      {"<leader>ro", "<cmd>MoltenEvaluateOperator<CR>", desc = "Molten evaluate operator"},
      {"<leader>rs", "<cmd>noautocmd MoltenEnterOutput<CR>", desc = "Molten enter output"},
      {"<leader>rr", "<cmd>MoltenReevaluateCell<CR>", desc = "Molten re-evaluate cell"},
      {"<leader>rv", "<cmd><C-u>MoltenEvaluateVisual<CR>gv", mode = {"v"}, desc = "Molten execute visual selection"},
      {"<leader>rh", "<cmd>MoltenHideOutput<CR>", desc = "Molten close output window"},
      {"<leader>rh", "<cmd>MoltenDelete<CR>", desc = "Molten delete cell"},
    }
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "benlubas/molten-nvim",
      "hrsh7th/nvim-cmp",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        languages = { "python" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = { enabled = true },
      },
      -- keymap = { hover = "<leader>rk" },
      -- TODO: Maybe set keymap config
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    ft = { "quarto", "markdown" },
    keys = {
      { "<leader>rc", function() require("quarto.runner").run_cell() end, desc = "Run Quarto cell"},
      { "<leader>ra", function() require("quarto.runner").run_above() end, desc = "Run Quarto cell and above"},
      { "<leader>rA", function() require("quarto.runner").run_all() end, desc = "Run all Quarto cells"},
      { "<leader>rl", function() require("quarto.runner").run_line() end, desc = "Run Quarto line"},
      { "<leader>r", function() require("quarto.runner").run_range() end, mode = {"v"}, desc = "Run Quarto visual range"},
      -- { "<leader>rk", function() require("otter").ask_hover() end, desc = "Quarto hover", silent = false},
      -- { "<C-K>", function() require("otter").ask_hover() end, mode = {"i"}, desc = "Quarto hover"},
    }
  },
  {
    "jmbuhr/otter.nvim",
    opts = {
      buffers = {
        set_filetype = true,
      }
    }
  },
  -- {
  --   "chrisgrieser/nvim-various-textobjs",
  --   -- lazy = true,
  --   keys = {
  --     {
  --       "ic",
  --       "<cmd>lua require('various-textobjs').mdFencedCodeBclock('inner')<CR>",
  --       { "o", "x" },
  --       desc = "Select inner md code block",
  --       buffer = true
  --     },
  --     {
  --       "ac",
  --       "<cmd>lua require('various-textobjs').mdFencedCodeBlock('outer')<CR>",
  --       { "o", "x" },
  --       desc = "Select outer md code block",
  --       buffer = true
  --     },
  --   },
  -- },
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
