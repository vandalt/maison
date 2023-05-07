Util = require("utils")

local zk_start_week = "sunday"

return {
  {
    "mickael-menu/zk-nvim",
    name = "zk",
    event = function()
      local notes_path = "/home/vandal/notes"
      local notes_pattern = "*" .. notes_path .. "*"
      local au_tbl = { "BufEnter " .. notes_pattern }
      if vim.fn.getcwd() == notes_path then
        au_tbl = vim.list_extend(au_tbl, {"BufEnter *"})
      end
      return au_tbl
    end,
    opts = {
      picker = "telescope",
      lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
          cmd = { "zk", "lsp" },
          name = "zk",
          -- on_attach = on_attach,
          -- capabilities = capabilities,
          -- etc, see `:h vim.lsp.start_client()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    },
    keys = {
      { "<leader>zn", function() require("zk").new({ title = vim.fn.input("Title: "), dir = vim.fn.input("Dir: ", "", "dir") }) end, desc = "New note (zk)" },
      { "<leader>zd", function() require("zk").new({ dir = 'daily' }) end, desc = "Daily log (zk)" },
      { "<leader>zz", function() require("zk").new({ title = vim.fn.input('Title: '), dir = 'zettel' }) end, desc = "New Zettel file (zk)" },
      { "<leader>zr", function() require("zk").new(Util.create_reading_tbl()) end, desc = "New reading note (zk)" },
      -- The function ensures that if today is the desired week day, use today and not one week ago
      { "<leader>zww", function() require("zk").new({ dir = 'weekly', date = Util.get_date_zw(zk_start_week) }) end, desc = "Weekly log (zk)" },
      { "<leader>zwl", function() require("zk").new({ dir = 'weekly', date = zk_start_week .. " last week" }) end, desc = "Last weekly log (zk)" },
      { "<leader>zwn", function() require("zk").new({ dir = 'weekly', date = "next" .. zk_start_week }) end, desc = "Next weekly log (zk)" },
      { "<leader>zk", function() require("zk").new({ title = 'backlog' }) end, desc = "Go to backlog (zk)" },
      { "<leader>zn", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.input('Dir: ', '', 'dir') }<CR>", mode = {"x"}, desc = "New note from title selection" },
      { "<leader>zz", ":'<,'>ZkNewFromTitleSelection { dir = 'zettel' }<CR>", mode = {"x"}, desc = "New zettel from title selection" },
      { "<leader>zo", "<Cmd>ZkNotes<CR>", desc = "Open note (zk)" },
      { "<leader>zi", "<Cmd>ZkIndex<CR>", desc = "Index notes (zk)"},
      { "<leader>zt", "<Cmd>ZkTags<CR>", desc = "Search tags (zk)" },
      { "<leader>zl", "<Cmd>ZkLinks<CR>", desc = "Search links (zk)" },
      { "<leader>zb", "<Cmd>ZkBacklinks<CR>", desc = "Search backlinks (zk)" },
      { "<leader>zf", "<Cmd>ZkNotes { match = { vim.fn.input('Search: ') } }<CR>", desc = "Search notes matching query (zk)"},
      { "<leader>zf", ":'<,'>ZkMatch<CR>", mode = { "x" }, desc = "Search notes matching selection (zk)"}
    }
  },

  {
    "jakewvincent/mkdnflow.nvim",
    name = "mkdnflow",
    opts = {
      modules = {
        buffers = false,
      },
      mappings = {
        MkdnEnter = { "i", "<CR>" },
        MkdnFollowLink = { "n", "<CR>" },
        MkdnDecreaseHeading = { "n", "=" },
        MkdnTableNewRowBelow = { "n", "<leader>ir" },
        MkdnTableNewRowAbove = { "n", "<leader>iR" },
        MkdnTableNewColAfter = { "n", "<leader>ic" },
        MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
        MkdnTableNewColBefore = { "n", "<leader>iC" },
        MkdnYankAnchorLink = { "n", "yal" },
      },
      links = {
        -- TODO: Trying to turn off and see how treesitter does it
        conceal = false,
        transform_explicit = function(text)
          text = text:gsub(" ", "-")
          text = text:lower()
          return text
        end,
      },
      perspective = {
        priority = "current",
        root_tell = "index.md",
      },
    }
  },

  {
    "ekickx/clipboard-image.nvim",
    opts = {
      default = {
        img_dir = { "%:p:h", "img" },
      }
    },
    keys = {
      { "<leader>ip", "<Cmd>PasteImg<CR>", desc = "Paste image" },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  }
}
