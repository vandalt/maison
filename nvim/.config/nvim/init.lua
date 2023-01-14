-- Make sure packer is installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Packadd is there because making optional below
vim.cmd [[packadd packer.nvim]]
local use = require('packer').use
require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }
  use 'lewis6991/impatient.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  -- use 'tpope/vim-fugitive'
  use 'sindrets/diffview.nvim'
  use { 'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    commit = "1acb13c07b34622fe1054695afcecff537d9a00a",
  }
  use 'tpope/vim-rhubarb'
  if vim.fn.executable "gh" == 1 then
    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
    }
  end
  use 'tpope/vim-eunuch' -- Enhanced unix shell commands
  use 'tpope/vim-sleuth' -- heuristically set indentation
  use 'tpope/vim-vinegar' -- nicer file navigation
  use {'prichrd/netrw.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
  -- use 'github/copilot.vim'
  -- use 'axelf4/vim-strip-trailing-whitespace' -- Remove white spaces only on modified lines
  use 'szw/vim-maximizer'
  use "AndrewRadev/splitjoin.vim" -- Join and split lines with gS/gJ
  use 'justinmk/vim-gtfo' -- Go to terminal (got) or file manager (gof)
  use 'ggandor/leap.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'tommcdo/vim-exchange' -- Exchange text objects with cx/cxx
  use 'vim-scripts/ReplaceWithRegister' -- Replace text object with gr
  use { "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup { }
  end,
  }
  use 'KenN7/vim-arsync' -- Sync remote files with rsync
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  use {
    'numToStr/Comment.nvim',
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  use {
    "folke/which-key.nvim",
  }
  -- NOTE: For some reason, un-installing which-key made gitsigns mappings work
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  }
  use { 'rbonvall/vim-textobj-latex', requires = 'kana/vim-textobj-user' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig'
  -- use "ray-x/lsp_signature.nvim"
  -- use "barreiroleo/ltex-extra.nvim"
  use "~/repos/ltex_extra.nvim/"
  use {
    'j-hui/fidget.nvim',
  }
  use 'mfussenegger/nvim-dap'
  use { 'theHamsta/nvim-dap-virtual-text', requires = 'mfussenegger/nvim-dap' }
  -- use { '~/perso/nvim-dap-virtual-text', requires = 'mfussenegger/nvim-dap' }
  use { 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'mickael-menu/zk-nvim'

  use({'jakewvincent/mkdnflow.nvim',
      rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
  })

  use 'ekickx/clipboard-image.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-copilot'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/nvim-cmp'
  use { 'kkoomen/vim-doge', run = ':call doge#install()' } -- Auto-generate docstring
  use 'windwp/nvim-autopairs'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-z.nvim',
      'nvim-telescope/telescope-dap.nvim',
    }
  }
  use 'nvim-telescope/telescope-ui-select.nvim' 
  use 'goerz/jupytext.vim' -- Convert and open jupyter notebooks
  use { 'bfredl/nvim-ipy', run = ':UpdateRemotePlugins' }
  use 'hkupty/iron.nvim'
  use 'jpalardy/vim-slime'
  use {
    -- 'GCBallesteros/vim-textobj-hydrogen',
    '~/repos/vim-textobj-hydrogen',
    requires = 'kana/vim-textobj-user' 
  }
  use 'akinsho/nvim-toggleterm.lua'
  use {
      -- Highlight cursor-word like an IDE.
      'nyngwang/murmur.lua',
      config = function ()
        require('murmur').setup {
          -- cursor_rgb = 'purple', -- default to '#393939'
          max_len = 80, -- maximum word-length to highlight
          -- min_len = 3,
          -- disable_on_lines = 2000, -- to prevent lagging on large files. Default to 2000 lines.
          exclude_filetypes = {},
          callbacks = {
            -- to trigger the close_events of vim.diagnostic.open_float.
            function ()
              -- Close floating diag. and make it triggerable again.
              vim.cmd('doautocmd InsertEnter')
              vim.w.diag_shown = false
            end,
          }
        }
        vim.api.nvim_create_autocmd('CursorHold', {
          group = FOO,
          pattern = '*',
          callback = function ()
            -- skip when a float-win already exists.
            if vim.w.diag_shown then return end

            -- open float-win when hovering on a cursor-word.
            if vim.w.cursor_word ~= '' then
              vim.diagnostic.open_float(nil, {
                focusable = false,
                close_events = { 'InsertEnter' },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
              })
              vim.w.diag_shown = true
            end
          end
        })
      end
    }
  use 'folke/tokyonight.nvim'
  use 'shaunsingh/nord.nvim'
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }
end)

require('impatient')

-- Window options
vim.o.mouse = "a"
vim.wo.list = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.hidden = true
vim.o.clipboard = "unnamedplus"
vim.o.title = true

-- Save/backup options
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.undofile = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Line numbers (relative to current line)
vim.wo.number = true
vim.wo.relativenumber = true

-- Color column at 80, 89
vim.wo.colorcolumn = "80,89"

-- Built-in completion
vim.o.completeopt = "menuone,noselect"

-- Enable filetype plugin
vim.cmd [[filetype plugin on]]

-- Remove trailing spaces on whole file
vim.api.nvim_set_keymap('n', '<leader>cw', '<Cmd>%s/\\s\\+$//e|norm!``<CR>', { noremap = true, silent = true })

-- Completion in wildmode
-- Commenting out fits because I often need to auto-complete them in scripts
local wignorelist = {
  '.git', '.svn',
  -- '*.jpg', '*.bmp', '*.gif', '*.png', '*.jpeg', '*.mp3',
  '*.pyc', '*.o', '*.so', '*.out',
  '*.hdf5',
  --  '*.fits', '*.pdf'
}
vim.o.wildmode = 'longest:full'
vim.o.wildignore = vim.o.wildignore .. table.concat(wignorelist, ",")

-- Hide dotfiles in netrw
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'

-- Highlighted yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)


vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {}) 

-- Colors
vim.cmd [[syntax enable]]
-- vim.g.gruvbox_italic = 1
vim.o.termguicolors = true
-- vim.g.nord_bold = false
-- require('nord').set()
require("tokyonight").setup({
  style = "night",
  -- style = "day",
  -- transparent = true,
})
vim.cmd [[colorscheme tokyonight]]

-- Function with a few defaults to write prose (Global so can call in editor)
function Prose()

  local function map(mode, l, r, opts)
    opts = opts or {}
    vim.keymap.set(mode, l, r, opts)
  end

  map('n', '<leader>ap', 'vasgq', { noremap = true, buffer = true }) -- Line to paragraph
  map('n', '<leader>al', 'vipJ', { noremap = true, buffer = true }) -- Paragraph to line
  -- vim.bo.textwidth = 80
  -- vim.bo.formatoptions = vim.bo.formatoptions .. 't' -- Wrap on width
  -- vim.wo.linebreak = true
  vim.wo.wrap = true
  vim.wo.list = false
  vim.o.display = 'lastline'
  -- vim.bo.autoindent = false
  -- vim.bo.cindent = false
  -- vim.bo.smartindent = false
  -- vim.bo.indentexpr = ''
  vim.wo.colorcolumn = ''
  map({'n', 'v'}, 'j', 'gj', { noremap = true, buffer = true })
  map({'n', 'v'}, 'gj', 'j', { noremap = true, buffer = true })
  map({'n', 'v'}, 'k', 'gk', { noremap = true, buffer = true })
  map({'n', 'v'}, 'gk', 'k', { noremap = true, buffer = true })
end

-- vim.cmd [[autocmd FileType tex,plaintex lua Prose()]]
vim.cmd [[autocmd BufNewFile,BufRead *.md,*.txt,*.tex lua Prose()]]


-- Mappings

-- Tmux and vim navigation
vim.g.tmux_navigator_no_mappings = true
vim.api.nvim_set_keymap("n", "<M-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-j>", ":TmuxNavigateDown<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-k>", ":TmuxNavigateUp<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-l>", ":TmuxNavigateRight<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-\\>", ":TmuxNavigatePrevious<CR>", { noremap = true, silent = true })

-- Écriture inclusive
vim.api.nvim_set_keymap("i", "<M-.>", "<C-v>u00b7", { noremap = true })
vim.api.nvim_set_keymap("i", "<M-d>", "📅", { noremap = true })
vim.api.nvim_set_keymap("i", "<M-u>", "μ", { noremap = true })

-- Size windows
vim.api.nvim_set_keymap('n', '<leader>=', '<C-w>=', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-,>', '<C-w><', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-.>', '<C-w>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-=>', '<C-w>+', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-->', '<C-w>-', { noremap = true })

-- Edit and load config
vim.api.nvim_set_keymap('n', '<leader>cv', ':vsplit $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>lv', ':luafile $MYVIMRC<CR>', { noremap = true })

-- Navigate
-- vim.api.nvim_set_keymap('n', '<leader>v', '<Plug>VinegarUp', { noremap = true })

vim.keymap.set('i', '<C-f>', '<C-k>', { noremap = true })

-- Move line in up or down file
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Esc>:m .+1<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Esc>:m .-2<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-j>', ':m \'>+1<CR>gv=gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-k>', ':m \'<-2<CR>gv=gv', { noremap = true })

-- vim.api.nvim_set_keymap('i', '<C-f>', 'i_digraph', { noremap = true })

-- Switch 0 and ^ (we can use _ instead of ^ to avoid a recursive mapping)
vim.api.nvim_set_keymap("n", "0", "_", {})
vim.api.nvim_set_keymap("n", "^", "999h", {})
vim.api.nvim_set_keymap("n", "<leader>0", "^", {})

-- (Double) Escape in terminal
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true })

-- Switch CWD to the directory of the open buffer
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>', {})

-- Remove search highlights
vim.api.nvim_set_keymap('n', '<ESC>', ':nohlsearch<CR>', { noremap = true })

-- Spell check
vim.api.nvim_set_keymap('', '<A-f>', ':setlocal spell! spelllang=fr<CR>', {})
vim.api.nvim_set_keymap('', '<A-e>', ':setlocal spell! spelllang=en_ca<CR>', {})

-- Maximize/reset splits
vim.api.nvim_set_keymap("n", "<leader>mm", ":MaximizerToggle!<CR>", { noremap = true })

-- Packer commands
vim.api.nvim_set_keymap('n', '<leader>pp', ':PackerSync<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ps', ':PackerStatus<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pi', ':PackerInstall<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pc', ':PackerCompile<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pl', ':PackerClean<CR>', { noremap = true })


---- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- require "lsp_signature".setup {}

-- LSP settings
local lspconfig = require 'lspconfig'

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ls', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set({'n', 'v'}, '<space>sf', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- if client.server_capabilities.document_formatting then
  --   vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --   vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  -- end
  if client.server_capabilities.document_range_formatting then
    FormatRange = function()
      local start_pos = vim.api.nvim_buf_get_mark(0, '<')
      local end_pos = vim.api.nvim_buf_get_mark(0, '>')
      vim.lsp.buf.range_formatting({}, start_pos, end_pos)
    end
    vim.cmd [[
      command! -range FormatRange  execute 'lua FormatRange()'
    ]]
  end
end


local null_ls = require("null-ls")

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.flake8.with({
      args = { "--ignore", "E501,W503,E203,E402,E722,E111,E114,E226", "--format", "default", "--stdin-display-name", "$FILENAME", "-" }
    }),
    null_ls.builtins.diagnostics.rpmspec,
  },
  on_attach = on_attach,
}


-- Make runtime files discoverable
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- HACK: This workaround disables ltex in settings, but not actual LSP
-- works to supprress error messages, which is what I needed
local function get_enable_ltex()
  -- local filename = vim.api.nvim_buf_get_name(0)
  local filename = vim.fn.getcwd()
  if string.match(filename, "notes") then
    return false
  end
  return {"bibtex", "context", "context.tex", "html", "latex", "markdown", "org", "restructuredtext", "rsweave", "mail"}
end
local enable_ltex = get_enable_ltex()

-- List of all servers
local servers = {
  'sumneko_lua',
  'pyright',
  'bashls',
  'yamlls',
  'cssls',
  'texlab',
  'jsonls',
  'ccls',
  'ltex',
  'fortls',
}
-- Table with custom settings when required
local lsp_settings = {
  ltex = {
    cmd = { "/home/vandal/programs/ltex-ls-15.2.0/bin/ltex-ls" },
    root_dir = function(filename, bufnr)
      -- Disable LSP for files in notes directory
      if string.match(filename, "notes") then
        print("Done")
        return nil
      end
      print("NOT DONE")
      return require("lspconfig.server_configurations.ltex").default_config.root_dir(filename, bufnr)
    end,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("ltex_extra").setup{
          load_langs = { "fr", "en-US" },
          init_check = true,
          path = "/home/vandal/.local/share/ltex",
          log_level = "warn",
      }
    end,
    -- filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "mail" },
    filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "mail" },
    -- NOTE: ltex_extra crashes if no settings set,so using this one to fix
    settings = {
      ltex = {
        -- Set enabled to false if full path of current file contains "notes"
        enabled = enable_ltex,
        -- enabled = {"bibtex", "context", "context.tex", "html", "latex", "markdown", "org", "restructuredtext", "rsweave", "mail"}
      },
    }
  },
  bashls = {
    cmd_env = {
      GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zsh)"
    },
    filetypes = { 'zsh', 'sh' },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          -- diagnosticMode = 'openFilesOnly',
        }
      }
    }
  },
  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
  },
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
  },
  sumneko_lua = {
    cmd = { "/home/vandal/programs/lua-language-server/bin/lua-language-server", "-E", "/home/vandal/programs/lua-language-server/bin/main.lua" },
    -- cmd = { "lua-language-server", "-E", "/usr/lib/lua-language-server/main.lua" },
    settings = {
      Lua = {
        runtime = {
          -- Lua version (most likely LuaJIT for Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
          maxPreload = 2000,
          preloadFileSize = 1000,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
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
          -- args = { "-pdf", "-pdflatex=xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
          -- args = { "-pdf", "-pdflatex=lualatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
          args = { "-pdf", "-pdflatex=pdflatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
          -- args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        },
        forwardSearch = {
          -- executable = "okular",
          -- args = {"--unique", "file:%p#src:%l%f"},
          executable = "zathura",
          args = { '--synctex-forward', '%l:1:%f', '%p' },
          -- executable =  "evince-synctex",
          -- args =  {"-f", "%l", "%p", "\"code -g %f:%l\""},
          -- args =  {"-f", "%l", "%p", '"nvr --remote-silent %f -c %l --servername /tmp/texsocket"'},
          onSave = true,
        }
      }
    }
  }
}
local function tbl_merge(...)
  local new_tbl = {}
  for _, tbl in ipairs { ... } do
    for k, v in pairs(tbl) do
      new_tbl[k] = v
    end
  end
  return new_tbl
end

-- Setup with or without custom settings and with capabilities for nvim-cmp
local common_tbl = { on_attach = on_attach, capabilities = capabilities }
for _, lsp in ipairs(servers) do
  if lsp_settings[lsp] then
    lspconfig[lsp].setup(tbl_merge(common_tbl, lsp_settings[lsp]))
  else
    lspconfig[lsp].setup(common_tbl)
  end
end

if vim.fn.exists(":TexlabBuild") then
  vim.api.nvim_set_keymap("n", "<leader>tb", "<Cmd>TexlabBuild<CR>", { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<leader>tf", "<Cmd>TexlabForward<CR>", { noremap = true, silent = false })
end


-- -- Next functions lines are from:
-- -- https://github.com/neovim/nvim-lspconfig/issues/726#issuecomment-1075539112
-- -- Disables pyright report _value as unused
-- local function filter(arr, func)
--   -- Filter in place
--   -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
--   local new_index = 1
--   local size_orig = #arr
--   for old_index, v in ipairs(arr) do
--     if func(v, old_index) then
--       arr[new_index] = v
--       new_index = new_index + 1
--     end
--   end
--   for i = new_index, size_orig do arr[i] = nil end
-- end
--
-- local function filter_diagnostics(diagnostic)
--   -- Only filter out Pyright stuff for now
--   if diagnostic.source ~= "Pyright" then
--     return true
--   end
--
--   -- Allow kwargs to be unused, sometimes you want many functions to take the
--   -- same arguments but you don't use all the arguments in all the functions,
--   -- so kwargs is used to suck up all the extras
--   if diagnostic.message == '"kwargs" is not accessed' then
--     return false
--   end
--
--   -- Allow variables starting with an underscore
--   if string.match(diagnostic.message, '"_.+" is not accessed') then
--     return false
--   end
--
--   return true
-- end
--
-- local function custom_on_publish_diagnostics(a, params, client_id, c, config)
--   filter(params.diagnostics, filter_diagnostics)
--   vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
-- end
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   custom_on_publish_diagnostics, {})


-- Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_b = { 'branch', 'filename', 'diagnostics' },
    lualine_c = { function()
      local ts_status = vim.fn['nvim_treesitter#statusline']()
      if ts_status == vim.NIL then
        ts_status = ""
      end
      return ts_status
    end },
  },
}

-- Useful for markdonw link creation and navigation
vim.cmd('autocmd FileType markdown set autowriteall')
vim.cmd('autocmd BufLeave *.md silent! wall')

require("mkdnflow").setup({
  mappings = {
    MkdnEnter = {{'i', 'n', 'v'}, '<CR>'},
    MkdnDecreaseHeading = {'n', '='},
    MkdnTableNewRowBelow = {'n', '<leader>ir'},
    MkdnTableNewRowAbove = {'n', '<leader>iR'},
    MkdnTableNewColAfter = {'n', '<leader>ic'},
    MkdnTableNewColBefore = {'n', '<leader>iC'},
    MkdnYankAnchorLink = {'n', 'yal'},
  },
  links = {
    conceal = true,
    transform_explicit = function(text)
      text = text:gsub(" ", "-")
      text = text:lower()
      return(text)
    end
  },
  perspective = {
    priority = "current",
    root_tell = "index.md"
  }
})

require("zk").setup {
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "telescope",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      on_attach = on_attach,
      capabilities = capabilities,
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
}

function get_date_zw()
  local start_week_day = "sunday"
  if string.lower(os.date("%A")) == start_week_day then
    return "today"
  else
    return start_week_day
  end
end

function create_reading_tbl()
  local author = vim.fn.input('Author: ')
  local year = vim.fn.input('Year: ')
  local readingid = vim.fn.input('Reading ID: ')

  local title = table.concat({author, year, readingid}, " ")

  local zk_tbl = {title = title, dir = "readings", extra = {author=author, year=year, readingid=readingid}}
  -- NOTE: This would be the code to return str with table info instead, keeping in case
  -- local reading_str = vim.inspect(zk_tbl, {newline = " ", indent=""})
  -- return reading_str
  return zk_tbl
end

local zk_opts = { noremap = true, silent = false }
-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.input('Dir: ', '', 'dir') }<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zd", "<Cmd>ZkNew { dir = 'daily' }<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zz", "<Cmd>ZkNew { title = vim.fn.input('Title: '), dir = 'zettel' }<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zr", "<Cmd>ZkNew create_reading_tbl()<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zw", "<Cmd>ZkNew { dir = 'weekly', date = get_date_zw() }<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zk", "<Cmd>ZkNew { title = 'backlog' }<CR>", zk_opts)
vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.input('Dir: ', '', 'dir') }<CR>", zk_opts)
vim.api.nvim_set_keymap("v", "<leader>zz", ":'<,'>ZkNewFromTitleSelection { dir = 'zettel' }<CR>", zk_opts)
vim.api.nvim_set_keymap("v", "<leader>zr", ":'<,'>ZkNewFromTitleSelection create_reading_tbl()<CR>", zk_opts)
-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes<CR>", zk_opts)
-- Index notes
vim.api.nvim_set_keymap("n", "<leader>zi", "<Cmd>ZkIndex<CR>", zk_opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", zk_opts)
-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { match = vim.fn.input('Search: ') }<CR>", zk_opts)
-- Search links
vim.api.nvim_set_keymap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>za", "<Cmd>Move archive/<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", zk_opts)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", zk_opts)

-- -- Treesitter config
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "python",
    "bash",
    "fortran",
    "c",
    "lua",
    "rust",
    "cpp",
    "go",
    "html",
    "julia",
    "latex",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    disable = { 'html' },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
    disable = { "python", "html" },
  },
  -- From https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ao"] = "@class.outer",
        ["io"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

-- LuaSnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-i>'] = cmp.mapping.confirm {
      -- Replaces chars after suggestion
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- Does not replace after, makes zk+cmp+autopairs work
    ['<CR>'] = cmp.mapping.confirm { select = false },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    -- { name = 'copilot' },
  },
}

-- LSP mappings
vim.keymap.set('n', '<leader>lr', ':LspRestart<CR>', { silent = true })
vim.keymap.set('n', '<leader>li', ':LspInfo<CR>', { silent = true })
vim.keymap.set('n', '<leader>ll', ':LspStart<CR>', { silent = true }) -- "launch"
vim.keymap.set('n', '<leader>lt', ':LspStop ', { silent = false })

-- Doge mapping
vim.g.doge_mapping = '<leader>ld'
-- python docstring types
vim.g.doge_doc_standard_python = 'sphinx'
vim.keymap.set('n', '<leader>ln', ':DogeGenerate numpy<CR>', { silent = true })


-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })
)

-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
-- cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

-- put this to setup function and press <a-e> to use fast_wrap
local npairs = require('nvim-autopairs')
npairs.setup({
 fast_wrap = {},
})


-- Debugger
local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/vandal/programs/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.fortran = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    args = function()
      return {vim.fn.input('Arguments: ', '', 'file'),}
    end,
  },
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

dap.adapters.python = {
  type = 'executable';
  -- command = '/home/vandal/programs/debugpy/venv/bin/python';
  command = '/usr/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    justMyCode = false;
    pythonPath = function()
      local venv_path = os.getenv("VIRTUAL_ENV")
      if venv_path then
        return venv_path .. "/bin/python"
      end
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
require("nvim-dap-virtual-text").setup()

-- Mappings
vim.api.nvim_set_keymap('n', '<leader>d<space>', "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>de', "<cmd>lua require'dap'.terminate()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dj", "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require'dap'.up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require'dap'.down()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require'dap'.run_to_cursor()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dB", "<cmd>lua require'dap'.toggle_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dro", "<cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>drr", "<cmd>lua require'dap'.repl.toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>drc", "<cmd>lua require'dap'.repl.close()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dfb', "<cmd>lua require'telescope'.extensions.dap.list_breakpoints()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dfv', "<cmd>lua require'telescope'.extensions.dap.variables()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dff', "<cmd>lua require'telescope'.extensions.dap.variables()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dfc', "<cmd>lua require'telescope'.extensions.dap.commands()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dtr', "<cmd>DapVirtualTextForceRefresh<cr>", { noremap = true })


require('gitlinker').setup()
require('neogit').setup {
  kind = "split_above",
  integrations = { diffview = true }
}
if vim.fn.executable "gh" == 1 then
  require('octo').setup()
end
require('Comment').setup()
require("todo-comments").setup {
  keywords = {
    -- TODO: See if can get this to work with "???" as alt
    -- https://github.com/folke/todo-comments.nvim/issues/56
    QUESTION = {
      icon = " ",
      color = "info",
    },
  },
}
require("which-key").setup()
require("trouble").setup()
require("fidget").setup()

vim.api.nvim_set_keymap('n', '<leader>mp', '<Plug>MarkdownPreviewToggle', { silent = true })

-- TODO: Rewrite in lua
vim.cmd(
[[
function OpenMarkdownPreview (url)
  execute "silent ! firefox --new-window " . a:url
endfunction
]]
)
vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'

require 'clipboard-image'.setup {
  default = {
    img_dir = { "%:p:h", "img" }
  },
}
vim.keymap.set('n', '<leader>ip', require('clipboard-image.paste').paste_img)

require('gitsigns').setup {
  signs = {
    -- Had trouble seeing color difference with lines for change and add
    add = { text = "+" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[h', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
    map('n', '<leader>hw', gs.toggle_current_line_blame) -- hunk "who?"... Running out of shortcuts!
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- Use %% cells for jupytext
vim.g.jupytext_fmt = 'py:percent'


require('toggleterm').setup {
  open_mapping = [[<A-\>]],
  start_in_insert = false,
}

-- Run a python file in terminal (opens one if none opened)
-- Subsitute spaces with '\ ' in final command
function RunPyFile()
  -- TODO: probably a way to do this with toggleterm+lua
  -- TODO: Separate function to handle the "shellescape" part
  local myfn = vim.fn.expand('%'):gsub(" ", "\\\\ "):gsub("#", "\\\\#")
  vim.cmd([[:TermExec cmd="python ]] .. myfn .. [["<CR>]])
end

function RunPyTest()
  vim.cmd([[:TermExec cmd="pytest"<CR>]])
end

function RunPyTestFile()
  -- TODO: probably a way to do this with toggleterm+lua
  -- TODO: Separate function to handle the "shellescape" part
  local myfn = vim.fn.expand('%'):gsub(" ", "\\\\ "):gsub("#", "\\\\#")
  vim.cmd([[:TermExec cmd="pytest ]] .. myfn .. [["<CR>]])
end

-- local mycmd = ':TermExec cmd="lua RunFile()python %' .. myfn .. '"<CR>'
vim.api.nvim_set_keymap('n', '<leader>pr', ":lua RunPyFile()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ptt', ":lua RunPyTest()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ptf', ":lua RunPyTestFile()<CR>", { noremap = true, silent = true })

-- Setup nvim-ipy
-- Gruvbox dark has dark text on dark background, so using light
vim.cmd [[ command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True") ]]
function SetupKernel()
  vim.cmd [[ RunQtConsole ]]
  -- Wait for console to open before connecting kernel
  os.execute("sleep 3")
  vim.cmd [[ IPython --existing --no-window ]]
end

-- vim.g.slime_target = "neovim"
vim.g.slime_target = "kitty"
-- vim.g.slime_bracketed_paste = 1

vim.g.ipy_celldef = '^# %%'
vim.g.nvim_ipy_perform_mappings = 0
vim.api.nvim_set_keymap('n', '<leader>jqt', ':RunQtConsole<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>jk', ':IPython --existing --no-window<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>jl', ':lua SetupKernel()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rc', '<Plug>(IPy-RunCell)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rr', '<Plug>(IPy-Run)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ra', '<Plug>(IPy-RunAll)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ro', '<Plug>(IPy-RunOp)', { silent = true })

-- Setup iron (sometimes more convenient to have REPL in nvim directly)
-- Last command also requires hydrogen text object
local iron = require("iron.core")
iron.setup {
  config = {
    highlight_last = false,
    should_map_plug = false,
    repl_definition = {
      python = require("iron.fts.python").ipython,
      nirps = {
        command = {"ssh", "pmaestria", "conda", "activate", "nirps-comm;", "ipython"}
      },
      jwst = {
        command = {"ssh", "pmaestria", "conda", "activate", "jwst-kpi;", "ipython"}
      },
      wise = {
        command = {"ssh", "pmaestria", "mamba", "activate", "wise-1828;", "ipython"}
      }
    },
    -- repl_open_cmd = 'topleft vertical 88 split',
    repl_open_cmd = require("iron.view").split.botright("30%")
  },
  keymaps = {
    send_motion = "<leader>sc",
    visual_send = "<leader>sc",
    send_line = "<leader>sl",
    cr = "<leader>s<cr>",
    interrupt = "<leader>s<leader>",
    exit = "<leader>sq",
    clear = "<leader>cl",
  }
}

local function open_custom_repl()
  local repl_name = vim.fn.input("Enter repl: ")
  _G.current_repl = repl_name
  vim.cmd([[:IronRepl ]] .. repl_name)
end

local function get_current_repl()
  if current_repl then
    return current_repl
  else
    return ""
  end
end

local ll = require("iron.lowlevel")
local ll_default_buffer = ll.get_buffer_ft

ll.get_buffer_ft = function(bufnr)
  local current = get_current_repl()
  if current == nil or current == "" then
    return ll_default_buffer(bufnr)
  end
  return current
end


local function wrap_iron_command(iron_cmd)
  vim.cmd([[:]] .. iron_cmd .. [[ ]] .. get_current_repl())
end

vim.keymap.set('n', '<leader>ir', function() wrap_iron_command("IronRepl") end, {})
vim.keymap.set("n", "<leader>ic", open_custom_repl, {noremap = true, silent = false})
-- vim.keymap.set('n', '<leader>if', function() wrap_iron_command("IronFocus") end, {})
-- vim.api.nvim_set_keymap('n', '<leader>ir', ':IronRepl<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>is', ':IronRestart<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>if', ':IronFocus<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>is', ':IronRestart<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>cc', '<leader>scacj]c', {})
vim.api.nvim_set_keymap('n', '<leader>cs', '<leader>scac', {})


-- Firenvim (off by default, use shortcut to set for FF addon to activate)
vim.opt.guifont = 'DejaVu\\ Sans\\ Mono:h18'
vim.g.firenvim_config = { localSettings = { ['.*'] = { takeover = 'never' } } }
vim.cmd [[au BufEnter github.com_*.txt set filetype=markdown]]

-- Telescope extensions
local telescope = require('telescope')
telescope.load_extension('fzy_native')
telescope.load_extension('z')
telescope.setup {
  defaults = {
    file_ignore_patterns = { "venv" },
  },
  extensions = {
    project = {
      base_dir = '~',
      max_depth = 3
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = { ["<c-d>"] = "delete_buffer" }
      }
    }
  }
}
-- telescope.load_extension('dap')
telescope.load_extension("ui-select")

-- built-in telescope mappings
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end)
vim.keymap.set('n', '<leader>fc', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end)
vim.keymap.set('n', '<leader>fi', function() require('telescope.builtin').symbols() end)
vim.keymap.set('n', '<leader>fz', function() require('telescope.builtin').current_buffer_fuzzy_find() end)
vim.keymap.set('n', 'z=', function() require('telescope.builtin').spell_suggest() end)
vim.keymap.set('n', '<leader>gc', function() require('telescope.builtin').git_commits() end)
vim.keymap.set('n', '<leader>gb', function() require('telescope.builtin').git_branches() end)
vim.keymap.set('n', '<leader>gs', function() require('telescope.builtin').git_status() end)
vim.keymap.set('n', '<leader>gf', function() require('telescope.builtin').git_bcommits() end)
vim.keymap.set('n', '<leader>wo', function() require('telescope.builtin').lsp_document_symbols() end)
vim.api.nvim_set_keymap('n', '<leader>ft', "<cmd>TodoTelescope<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>gg', ":Neogit<CR>", { noremap = true })
vim.keymap.set('n', '<leader>gd', ":DiffviewOpen<CR>", { noremap = true })
vim.keymap.set('n', '<leader>tc', ":tabclose<CR>", { noremap = true })

if vim.fn.executable "gh" == 1 then
  vim.keymap.set('n', '<leader>gii', ":Octo issue list<CR>", { noremap = true })
  vim.keymap.set('n', '<leader>gpp', ":Octo pr list<CR>", { noremap = true })
  vim.keymap.set('n', '<leader>gis', ":Octo issue search<CR>", { noremap = true })
  vim.keymap.set('n', '<leader>gps', ":Octo pr search<CR>", { noremap = true })
end

vim.api.nvim_set_keymap('n', '<leader>gY', '<cmd>lua require"gitlinker".get_repo_url()<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>gB', '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>', { silent = true })

-- ARsync mappings
vim.api.nvim_set_keymap("n", "<leader>su", ":ARsyncUp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sk", ":ARsyncUpDelete<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sd", ":ARsyncDown<CR>", { noremap = true })


require'netrw'.setup{}

leap = require('leap')
leap.add_default_mappings()
leap.opts.highlight_unlabeled_phase_one_targets = true
-- leap.init_highlight(true)
--

-- Colorblind-friendly Leap labels
vim.api.nvim_set_hl(0, "LeapLabelPrimary", {fg = "#9dcd6a"})
