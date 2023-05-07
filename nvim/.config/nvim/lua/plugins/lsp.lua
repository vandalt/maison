Util = require("utils")


return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "barreiroleo/ltex_extra.nvim",
        dev = false,
      },
    },
    -- event = { "BufReadPre", "BufNewFile", "BufEnter" },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>ct", ":LspStop ", desc = "Stop an LSP client", silent = false }
    end,
    opts = {
      autoformat = false,
      servers = {
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false
            }
          }
        },
        ltex = {
          settings = {
            ltex = {
              enabled = Util.get_enable_ltex(),
            }
          }
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                disagnosticMode = 'openFilesOnly'
              },
            },
          },
        },
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8"
          }
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
      setup = {
        texlab = function(_, opts)
          require("lazyvim.util").on_attach(function(client)
            if client.name == "texlab" then
              vim.keymap.set("n", "<leader>tb", "<Cmd>TexlabBuild<CR>", { desc = "Build Tex file" })
              vim.keymap.set("n", "<leader>tf", "<Cmd>TexlabForward<CR>", { desc = "Go to location in PDF" })
            end
          end)
        end,
        ltex = function(_, opts)
          require("lazyvim.util").on_attach(function(client)
            if client.name == "ltex" then
              require("ltex_extra").setup{
                load_langs = { "fr", "en-US" },
                init_check = true, -- boolean : whether to load dictionaries on startup
                path = vim.fn.expand("~") .. "/.local/share/ltex/",
                log_level = "warn", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
              }
            end
          end)
        end
      }
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    -- event = { "BufReadPre", "BufNewFile", "BufEnter" },
    opts = function(_, opts)
      local nls = require("null-ls")
      -- nls.builtins.formatting.stylua,
      -- nls.builtins.formatting.shfmt,
      -- nls.builtins.diagnostics.flake8,
      --
      opts.sources = {
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.diagnostics.flake8.with({
          args = {
            "--ignore",
            "E501,W503,E203,E402,E722,E111,E114,E226",
            "--format",
            "default",
            "--stdin-display-name",
            "$FILENAME",
            "-",
          },
        }),
      }
    end,
  },

}
