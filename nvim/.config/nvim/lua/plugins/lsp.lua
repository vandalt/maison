return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        yamlls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        texlab = {
          settings = {
            texlab = {
              bibtexFormatter = "latexindent",
              build = {
                forwardSearchAfter = false,
                onSave = true,
                -- TODO: Setup way to change pdflatex compiler automatically
                args = { "-pdf", "-pdflatex=xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                -- args = { "-pdf", "-pdflatex=lualatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                -- args = { "-pdf", "-pdflatex=pdflatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                -- args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              },
              forwardSearch = {
                -- executable = "okular",
                -- args = {"--unique", "file:%p#src:%l%f"},
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
                -- executable =  "evince-synctex",
                -- args =  {"-f", "%l", "%p", "\"code -g %f:%l\""},
                -- args =  {"-f", "%l", "%p", '"nvr --remote-silent %f -c %l --servername /tmp/texsocket"'},
                onSave = true,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
              type = {
                weakUnionCheck = true,
              },
            }
          }
        }
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.black,
          nls.builtins.formatting.isort,
        },
      }
    end,
  },

}
