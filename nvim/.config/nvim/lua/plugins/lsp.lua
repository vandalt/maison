return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        yamlls = { settings = { yaml = { keyOrdering = false } } },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                disagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8",
          },
        },
        vimls = {},
        julials = {},
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- enabled = false,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = {
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        -- nls.builtins.diagnostics.flake8.with({
        --   args = {
        --     "--ignore",
        --     "E501,W503,E203,E402,E722,E111,E114,E226,E265,E261",
        --     "--format",
        --     "default",
        --     "--stdin-display-name",
        --     "$FILENAME",
        --     "-",
        --   },
        -- }),
      }
    end,
  },
}
