---- Make sure packer is installed
--local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
--if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
--end
--
---- Packadd is there because making optional below
--vim.cmd [[packadd packer.nvim]]
--local use = require('packer').use
--require('packer').startup(function()
--
--  -- Inception - Load packer with packer
--  use {'wbthomason/packer.nvim', opt = true}
--
--end)

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
-- TODO: Remove when installing vim-sleuth, maybe
vim.cmd [[autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]]
vim.cmd [[autocmd Filetype lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]]
vim.cmd [[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]
vim.cmd [[autocmd Filetype markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]]
vim.cmd [[autocmd BufNewFile, BufRead *.ipynb setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]

-- Remove trailing spaces
-- TODO: find way to do this only on lines I edited
-- (and that keeps cursor at current location)
-- vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- Completion in wildmode
-- Commenting out fits because I often need to auto-complete them in scripts
local wignorelist = {
  '.git', '.svn',
  '*.jpg', '*.bmp', '*.gif', '*.png', '*.jpeg', '*.pdf', '*.mp3',
  '*.pyc', '*.o', '*.so', '*.out',
  '*.hdf5',
--  '*.fits',
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
