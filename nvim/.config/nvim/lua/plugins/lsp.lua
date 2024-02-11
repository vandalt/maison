return {
  {
    "neovim/nvim-lspconfig",
    cmd = {"LspStart", "LspInfo"},
    dependencies = {
      {
        "microsoft/python-type-stubs",
        cond = false,
      }
    },
    opts = {
      servers = {
        yamlls = { settings = { yaml = { keyOrdering = false } } },
        pyright = {
          filetypes = { "python" },
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
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
        marksman = {
          -- also needs:
          -- $home/.config/marksman/config.toml :
          -- [core]
          -- markdown.file_extensions = ["md", "markdown", "qmd"]
          filetypes = { "markdown", "quarto" },
          root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
      },
    },
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   -- enabled = false,
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = {
  --       nls.builtins.formatting.black,
  --       nls.builtins.formatting.isort,
  --       nls.builtins.formatting.stylua,
  --       nls.builtins.formatting.shfmt,
  --       -- nls.builtins.diagnostics.flake8.with({
  --       --   args = {
  --       --     "--ignore",
  --       --     "E501,W503,E203,E402,E722,E111,E114,E226,E265,E261",
  --       --     "--format",
  --       --     "default",
  --       --     "--stdin-display-name",
  --       --     "$FILENAME",
  --       --     "-",
  --       --   },
  --       -- }),
  --     }
  --   end,
  -- },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
      relative_width = true,
      width = 15,
    },
  },
}
