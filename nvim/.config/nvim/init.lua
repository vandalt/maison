-- Make sure packer is installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- Packadd is there because making optional below
vim.cmd [[packadd packer.nvim]]
local use = require('packer').use
require('packer').startup(function()

  -- Inception - Load packer with packer
  use {'wbthomason/packer.nvim', opt = true}

  use 'tpope/vim-surround'  -- mappings to surround text objects
  use 'tpope/vim-commentary'  -- map gc/gcc to comment
  use 'tpope/vim-repeat'  -- repeat some plugin maps with '.'
  use 'tpope/vim-fugitive'  -- git commands
  use 'tpope/vim-eunuch'  -- Enhanced unix shell commands
  use 'tpope/vim-unimpaired'  -- "Paired" commands with '[' and ']'
  use 'tpope/vim-sleuth'  -- Heuristically set indentation
  use 'tpope/vim-vinegar'  -- nicer file navigation
  use 'szw/vim-maximizer'  -- Maximize splits

  use 'justinmk/vim-gtfo'  -- Go to terminal (got) or file manager (gof)
  use 'christoomey/vim-tmux-navigator'  -- Navigate vim and tmux with same bindings
  use 'tommcdo/vim-exchange'  -- Exchange text objects with cx/cxx
  use 'vim-scripts/ReplaceWithRegister'  -- Replace text object with gr

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use 'neovim/nvim-lspconfig'

  use 'mickael-menu/zk-nvim'
  use 'ekickx/clipboard-image.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/nvim-cmp'

  use {'kkoomen/vim-doge', run = ':call doge#install()'}  -- Auto-generate docstring

  use 'windwp/nvim-autopairs'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-z.nvim',
    }
  }

  use 'goerz/jupytext.vim'  -- Convert and open jupyter notebooks
  use {'bfredl/nvim-ipy', run = ':UpdateRemotePlugins'}
  use 'akinsho/nvim-toggleterm.lua'

  -- Color scheme
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use 'folke/tokyonight.nvim'
  use 'shaunsingh/nord.nvim'

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end 
  }

end)

-- Window options
vim.o.mouse = "a"
vim.wo.list = true
vim.o.title = true
vim.o.shortmess = vim.o.shortmess.."c"
vim.o.hidden = true
vim.o.clipboard = "unnamedplus"

-- Save/backup options
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Line numbers (relative to current line)
vim.wo.number = true
vim.wo.relativenumber = true

-- Color column at 80, 89
vim.wo.colorcolumn = "80,89"

vim.o.completeopt = "menuone,noselect"

-- Enable filetype plugin
vim.cmd [[filetype plugin on]]

-- Indendation
-- -- TODO: Remove when installing vim-sleuth, maybe
-- vim.cmd [[autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]]
-- vim.cmd [[autocmd Filetype lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]]
-- vim.cmd [[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]
-- vim.cmd [[autocmd Filetype markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]]
-- vim.cmd [[autocmd BufNewFile, BufRead *.ipynb setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]

-- Remove trailing spaces
-- TODO: find way to do this only on lines I edited
-- (and that keeps cursor at current location)
-- vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- Completion in wildmode
-- Commenting out fits because I often need to auto-complete them in scripts
local wignorelist = {
  '.git', '.svn',
  '*.jpg', '*.bmp', '*.gif', '*.png', '*.jpeg', '*.mp3',
  '*.pyc', '*.o', '*.so', '*.out',
  '*.hdf5',
--  '*.fits', '*.pdf'
}
vim.o.wildmode = 'longest:full'
vim.o.wildignore = vim.o.wildignore..table.concat(wignorelist, ",")

-- Hide dotfiles in netrw
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'

-- Highlighted yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Colors
vim.cmd [[syntax enable]]
-- vim.g.gruvbox_italic = 1
vim.o.termguicolors = true
vim.cmd [[colorscheme tokyonight]]

-- Function with a few defaults to write prose (Global so can call in editor)
function Prose(bufnr)
  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  map('n', '<leader>ap', 'vasgq', {noremap = true})  -- Line to paragraph
  map('n', '<leader>al', 'vipJ', {noremap = true})  -- Paragraph to line
  vim.bo.textwidth = 80
  vim.bo.formatoptions = vim.bo.formatoptions..'t'  -- Wrap on width
  vim.wo.linebreak = true
  vim.wo.wrap = true
  vim.wo.list = false
  vim.o.display = 'lastline'
  vim.bo.autoindent = false
  vim.bo.cindent = false
  vim.bo.smartindent = false
  vim.bo.indentexpr = ''
  vim.wo.colorcolumn = ''
  map('n', 'j', 'gj', {noremap = true})
  map('n', 'k', 'gk', {noremap = true})
  map('v', 'j', 'gj', {noremap = true})
  map('v', 'k', 'gk', {noremap = true})
end
vim.cmd [[autocmd FileType tex,plaintex lua Prose()]]
vim.cmd [[autocmd BufNewFile,BufRead *.md lua Prose()]]


-- Mappings

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tmux and vim navigation
vim.g.tmux_navigator_no_mappings = true
vim.api.nvim_set_keymap("n", "<M-h>", ":TmuxNavigateLeft<CR>", {noremap = true, silent=true})
vim.api.nvim_set_keymap("n", "<M-j>", ":TmuxNavigateDown<CR>", {noremap = true, silent=true})
vim.api.nvim_set_keymap("n", "<M-k>", ":TmuxNavigateUp<CR>", {noremap = true, silent=true})
vim.api.nvim_set_keymap("n", "<M-l>", ":TmuxNavigateRight<CR>", {noremap = true, silent=true})
vim.api.nvim_set_keymap("n", "<M-\\>", ":TmuxNavigatePrevious<CR>", {noremap = true, silent=true})

-- Size windows
vim.api.nvim_set_keymap('n', '<leader>=', '<C-w>=', {noremap = true})
vim.api.nvim_set_keymap('n', '<M-,>', '<C-w><', {noremap = true})
vim.api.nvim_set_keymap('n', '<M-.>', '<C-w>>', {noremap = true})

-- Edit and load config
vim.api.nvim_set_keymap('n', '<leader>cv', ':vsplit $MYVIMRC<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>lv', ':luafile $MYVIMRC<CR>', {noremap = true})

-- Move line in up or down file
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<Esc>:m .+1<CR>==gi', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Esc>:m .-2<CR>==gi', {noremap = true})
vim.api.nvim_set_keymap('v', '<C-j>', ':m \'>+1<CR>gv=gv', {noremap = true})
vim.api.nvim_set_keymap('v', '<C-k>', ':m \'<-2<CR>gv=gv', {noremap = true})

-- Switch 0 and ^ (we can use _ instead of ^ to avoid a recursive mapping)
vim.api.nvim_set_keymap("n", "0", "_", {})
vim.api.nvim_set_keymap("n", "^", "999h", {})
vim.api.nvim_set_keymap("n", "<leader>0", "^", {})

-- (Double) Escape in terminal
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', {noremap = true})

-- Switch CWD to the directory of the open buffer
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>', {})

-- Remove search highlights
vim.api.nvim_set_keymap('n', '<ESC>', ':nohlsearch<CR>', {noremap = true})

-- Spell check
vim.api.nvim_set_keymap('', '<A-f>', ':setlocal spell! spelllang=fr<CR>', {})
vim.api.nvim_set_keymap('', '<A-e>', ':setlocal spell! spelllang=en_ca<CR>', {})

-- Maximize/reset splits
vim.api.nvim_set_keymap("n", "<leader>m", ":MaximizerToggle!<CR>", {noremap = true})

-- Packer commands
vim.api.nvim_set_keymap('n', '<leader>pp', ':PackerSync<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ps', ':PackerStatus<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pi', ':PackerInstall<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pc', ':PackerCompile<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pl', ':PackerClean<CR>', {noremap = true})


---- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- TODO: Uncomment when telescope is installed
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>Q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_buf_set_keymap("n", "<leader>sf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  end
  if client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_buf_set_keymap("v", "<leader>sf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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

-- Make runtime files discoverable
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- List of all servers
local servers = {'sumneko_lua', 'pyright', 'bashls', 'yamlls', "cssls"}
-- Table with custom settings when required
local lsp_settings = {
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
          typeCheckingMode = "off";
        }
      }
    }
  },
  cssls = {
    cmd = {"vscode-css-languageserver", "--stdio"},
  },
  sumneko_lua = {
    -- Full cmd when installed from Arch repos
    cmd = {"lua-language-server", "-E", "/usr/lib/lua-language-server/main.lua"},
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
  }
}
local function tbl_merge(...)
  local new_tbl = {}
  for _, tbl in ipairs{...} do
    for k, v in pairs(tbl) do
      new_tbl[k] = v
    end
  end
  return new_tbl
end
-- Setup with or without custom settings and with capabilities for nvim-cmp
local common_tbl = {on_attach=on_attach, capabilities=capabilities}
for _, lsp in ipairs(servers) do
  if lsp_settings[lsp] then
    lspconfig[lsp].setup(tbl_merge(common_tbl, lsp_settings[lsp]))
  else
    lspconfig[lsp].setup(common_tbl)
  end
end


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
      capabilities=capabilities,
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
}

local zk_opts = { noremap=true, silent=false }
-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zd", "<Cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.input('Dir: ') }<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zj", "<Cmd>ZkNew { dir = 'journal' }<CR>", zk_opts)
-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes<CR>", zk_opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", zk_opts)
-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { match = vim.fn.input('Search: ') }<CR>", zk_opts)
-- Search links
vim.api.nvim_set_keymap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", zk_opts)
vim.api.nvim_set_keymap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", zk_opts)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", zk_opts)
vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>ZkNewFromTitleSelection<CR>", zk_opts)

local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
parser_configs.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}


-- Treesitter config
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
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
  indent = { enable = true },
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
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
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
require("luasnip.loaders.from_vscode").load()

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
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
  },
}

-- Doge mapping
vim.g.doge_mapping = '<leader>ld'
-- python docstring types
vim.g.doge_doc_standard_python = 'sphinx'


-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({  map_char = { tex = '' } })
)

-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

-- put this to setup function and press <a-e> to use fast_wrap
local npairs = require('nvim-autopairs')
npairs.setup({
    fast_wrap = {},
})



-- Use %% cells for jupytext
vim.g.jupytext_fmt = 'py:percent'


require('toggleterm').setup{
  open_mapping = [[<A-\>]],
  start_in_insert = true,
}


-- Run a python file in terminal (opens one if none opened)
-- Subsitute spaces with '\ ' in final command
function RunPyFile()
  -- TODO: probably a better way to do this with toggleterm+lua
  -- TODO: Separate function to handle the "shellescape" part
  local myfn = vim.fn.expand('%'):gsub(" ", "\\\\ "):gsub("#", "\\\\#")
  vim.cmd([[:TermExec cmd="python ]] .. myfn .. [["<CR>]])
end
-- local mycmd = ':TermExec cmd="lua RunFile()python %' .. myfn .. '"<CR>'
vim.api.nvim_set_keymap('n', '<leader>pr', ":lua RunPyFile()<CR>", {noremap = true, silent = true})

-- Setup nvim-ipy
-- Gruvbox dark has dark text on dark background, so using light
vim.cmd [[ command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True") ]]
function SetupKernel()
  vim.cmd [[ RunQtConsole ]]
  -- TODO: Make work with windows
  -- Wait for console to open before connecting kernel
  os.execute("sleep 3")
  vim.cmd [[ IPython --existing --no-window ]]
end
vim.g.ipy_celldef = '^# %%'
vim.g.nvim_ipy_perform_mappings = 0
vim.api.nvim_set_keymap('n', '<leader>jqt', ':RunQtConsole<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jk', ':IPython --existing --no-window<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jl', ':lua SetupKernel()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>rc', '<Plug>(IPy-RunCell)', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>rr', '<Plug>(IPy-Run)', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ra', '<Plug>(IPy-RunAll)', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ro', '<Plug>(IPy-RunOp)', {silent = true})

-- Firenvim (off by default, use shortcut to set for FF addon to activate)
vim.opt.guifont = 'DejaVu\\ Sans\\ Mono:h18'
vim.g.firenvim_config = { localSettings = { ['.*'] = { takeover = 'never' } } }

-- Telescope extensions
local telescope = require('telescope')
telescope.load_extension('fzy_native')
telescope.load_extension('z')
telescope.setup {
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
        i = {["<c-d>"] = "delete_buffer"}
      }
    }
  }
}

-- built-in telescope mappings
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fi', [[<cmd>lua require('telescope.builtin').symbols()<cr>]], {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fz', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true })
