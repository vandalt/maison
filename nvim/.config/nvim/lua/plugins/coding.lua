Utils = require("utils")

local function jup_build_dev(devmode)
  if devmode then
    return {
      -- Alternative build if using system python
      -- build = "python  -m pip install --no-deps -U -e .",
      build = "pipx install --force -e .",
      dev = true,
    }
  else
    return {
      -- Alternative build if using system python
      -- build = "python  -m pip install --no-deps -U .",
      build = "pipx install --force .",
      dev = false,
    }
  end
end

return {

  {
    "goerz/jupytext.vim",
    enabled = vim.fn.executable("jupytext"),
    dependencies = {
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim",
    },
    -- lazy = true,
    -- event = { "BufReadPre *.ipynb", "BufEnter *.ipynb" },
    -- event = { "BufReadPre *.ipynb" },
    -- ft = "json",
    init = function()
      vim.g.jupytext_fmt = "py:percent"
    end
  },

  {
    "hkupty/iron.nvim",
    name = "iron",
    lazy = false,
    -- TODO: These will conflict with jupynium
    dependencies = {
      {
        dir = "~/repos/perso/vim-textobj-hydrogen/",
        dependencies = { "kana/vim-textobj-user" },
      },
    },
    opts = function()
      return {
        config = {
          highlight_last = false,
          repl_definition = {
            python = require("iron.fts.python").ipython,
          },
          repl_open_cmd = require("iron.view").split.botright("30%"),
        },
        keymaps = {
          send_motion = "<leader>sc",
          visual_send = "<leader>sc",
          send_line = "<leader>sl",
          cr = "<leader>s<cr>",
          interrupt = "<leader>s<leader>",
          exit = "<leader>sq",
          clear = "<leader>cl",
        },
      }
    end,
    config = function(_, opts)
      require("iron.core").setup(opts)
      -- vim.keymap.set("n", "<leader>cc", "<leader>scajj]j", { desc = "Run cell and go to next", remap = true })
      -- vim.keymap.set("n", "<leader>cs", "<leader>scaj", { desc = "Run cell", remap = true })
    end,
    keys = {
      { "<leader>ir", ":IronRepl<CR>", desc = "Toggle Iron REPL" },
      { "<leader>is", ":IronRestart<CR>", desc = "Restart Iron REPL" },
      { "<leader>if", ":IronFocus<CR>", desc = "Focus Iron REPL" },
      { "<leader>cc", "<leader>scajj]j", desc = "Run cell and go to next", remap = true },
      { "<leader>cs", "<leader>scaj", desc = "Run cell", remap = true },
    },
  },

  vim.tbl_extend(
    "error",
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
        { "<leader>jj", "<cmd>JupyniumExecuteSelectedCells<CR>]j", desc = "Jupynium execute cell and go to next", remap = true },
        { "<leader>jx", "<cmd>JupyniumExecuteSelectedCells<CR>", {"n", "x"}, desc = "Jupynium execute selected cell" },
        { "<leader>jc", "<cmd>JupyniumClearSelectedCellOutputs<CR>", {"n", "x"}, desc = "Jupynium clear selected cells" },
        { "<leader>jk", "<cmd>JupyniumKernelHover<CR>",  desc = "Jupynium hover (inspect a variable)" },
        { "<leader>jK", "<cmd>JupyniumKernelSelect<CR>",  desc = "Jupynium select kernel" },
        { "<leader>js", "<cmd>JupyniumScrollToCell<CR>", { "n", "x" },  desc = "Jupynium scroll to cell" },
        { "<leader>jo", "<cmd>JupyniumToggleSelectedCellsOutputsScroll<CR>", { "n", "x" }, desc = "Jupynium toggle selected cell output scroll" },
        { "<leader>jss", "<cmd>JupyniumStartAndAttachToServer<CR>", desc = "Jupynium start and attach to server" },
        { "<leader>jst", "<cmd>JupyniumStartAndAttachToServerInTerminal<CR>", desc = "Jupynium start and attach to server with terminal" },
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
          desc = "Go to next Jupynium cell" ,
        },
        {
          "<space>jh",
          "<cmd>lua require'jupynium.textobj'.goto_current_cell_separator()<cr>",
          mode = { "n", "x", "o" },
          desc = "Go to current Jupynium cell" ,
        },
        {
          "aj",
          "<cmd>lua require'jupynium.textobj'.select_cell(true, false)<cr>",
          mode = { "x", "o" },
          desc = "Select around Jupynium cell" ,
        },
        {
          "ij",
          "<cmd>lua require'jupynium.textobj'.select_cell(false, false)<cr>",
          mode = { "x", "o" },
          desc = "Select inside Jupynium cell" ,
        },
        {
          "aJ",
          "<cmd>lua require'jupynium.textobj'.select_cell(true, true)<cr>",
          mode = { "x", "o" },
          desc = "Select around Jupynium cell (include next cell separator)" ,
        },
        {
          "iJ",
          "<cmd>lua require'jupynium.textobj'.select_cell(false, true)<cr>",
          mode = { "x", "o" },
          desc = "Select inside Jupynium cell (include next cell separator)" ,
        },
      }
    },
    -- Build command will depend on dev mode or not
    jup_build_dev(false)
  ),

  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    init = function()
      vim.g.doge_doc_standard_python = "sphinx"
      vim.g.doge_python_settings = {
        omit_redundant_param_types = 0,
      }
      vim.g.doge_mapping = "<leader>dd"
      vim.keymap.set("n", "<leader>dn", ":DogeGenerate numpy<CR>", { silent = true })
    end,
  },

  -- Disable tab in luasnip (will re-enable via cmp)
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      -- If problems: https://github.com/kiyoon/jupynium.nvim#optionally-configure-nvim-cmp-to-show-jupyter-kernel-completion
      opts.sources = cmp.config.sources(vim.list_extend(
        opts.sources,
        {
          { name = "jupynium" },
        }
      ))

      for i, source in ipairs(opts.sources) do
        if source["name"] == "path" then
          opts.sources[i]["option"] = {
            get_cwd = function()
              return vim.fn.getcwd()
            end
          }
        end
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local luasnip = require("luasnip")
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping.confirm({
          select = false,
          behavior = cmp.ConfirmBehavior.Replace,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      mappings = {
        -- Auto add 2nd space in parentheses (not squre bc TODO in markdown)
        [' '] = { action = 'open', pair = '  ', neigh_pattern = '[%({][%)}]' },

        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%w]' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%w]' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%w]' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\][^%w]' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\][^%w]' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\][^%w]' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^A-Za-eg-z0-9\\"][^%w]', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^A-Za-eg-z0-9\\\'][^%w]', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%a\\`][^%w]', register = { cr = false } },
      },
    }
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
    }
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ma", -- Add surrounding in Normal and Visual modes
        delete = "md", -- Delete surrounding
        find = "mf", -- Find surrounding (to the right)
        find_left = "mF", -- Find surrounding (to the left)
        highlight = "mh", -- Highlight surrounding
        replace = "mr", -- Replace surrounding
        update_n_lines = "mn", -- Update `n_lines`
      },
    },
  }
}
