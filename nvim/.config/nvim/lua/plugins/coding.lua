return {
  {
    "echasnovski/mini.pairs",
    opts = {
      mappings = {
        -- Auto add 2nd space in parentheses (not square bc TODO in markdown)
        [" "] = { action = "open", pair = "  ", neigh_pattern = "[%({][%)}]" },

        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][^%w]" },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][^%w]" },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][^%w]" },

        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\][^%w]" },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\][^%w]" },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\][^%w]" },

        ['"'] = {
          action = "closeopen",
          pair = '""',
          neigh_pattern = '[^A-Za-eg-z0-9\\"][^%w]',
          register = { cr = false },
        },
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^A-Za-eg-z0-9\\'][^%w]",
          register = { cr = false },
        },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%a\\`][^%w]", register = { cr = false } },
      },
    },
  },
  {
    "echasnovski/mini.splitjoin",
    opts = {
      mappings = {
        toggle = "gS",
      },
      detect = {

        brackets = { '%b()', '%b[]', '%b{}' },
      },
    },
  },
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
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "jupynium" },
        { name = "otter" },
      }))

      -- TODO: Make this dependent on filetype or path. Pretty much only want this for 
      -- IPython files
      -- for i, source in ipairs(opts.sources) do
      --   if source["name"] == "path" then
      --     opts.sources[i]["option"] = {
      --       get_cwd = function()
      --         return vim.fn.getcwd()
      --       end,
      --     }
      --   end
      -- end

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
    end,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- config = true,
    opts = {
      snippet_engine = "luasnip",
      languages = {
        python = {
          template = {
            -- NOTE: With reST type hints act as type docstrings.
            -- i.e. no type docstring lines. This is expected behaviour.
            annotation_convention = "reST",
          },
        },
      },
    },
    keys = {
      {
        "<leader>nn",
        function()
          require("neogen").generate({})
        end,
        desc = "Generate annotation with Neogen",
      },
      {
        "<leader>np",
        function()
          require("neogen").generate({ annotation_convention = { python = "numpydoc" } })
        end,
        desc = "Generate Numpydoc annotation with Neogen",
      },
      {
        "<leader>ng",
        function()
          require("neogen").generate({ annotation_convention = { python = "google_docstrings" } })
        end,
        desc = "Generate Google docstrings annotation with Neogen",
      },
    },
  },
  {
    "echasnovski/mini.ai",
    opts = {
      n_lines = 1000,
    },
  },
  {
    "kmonad/kmonad-vim",
  },
  { "Glench/Vim-Jinja2-Syntax" },
  {
    "mfussenegger/nvim-dap-python",
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method({config = {justMyCode = false}}) end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class({config = {justMyCode = false}}) end, desc = "Debug Class", ft = "python" },
    },
    config = function()
      require('dap-python').test_runner = 'pytest'
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python", {include_configs = false})
      local configurations = require('dap').configurations.python
      for _, configuration in pairs(configurations) do
        configuration.justMyCode = false
      end
    end
  }
}
