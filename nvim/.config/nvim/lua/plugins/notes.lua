Util = require("utils")

return {
  {
    "mickael-menu/zk-nvim",
    name = "zk",
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
      { "<leader>zw", function() require("zk").new({ dir = 'weekly', date = Util.get_date_zw() }) end, desc = "Weekly log (zk)" },
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
}
