#!/usr/bin/bash

stow --dotfiles -vRt ~ nvim
stow --dotfiles --no-folding -vRt ~ bin bash zsh sway waybar swaylock kanshi mako kmonad rofi libinput-gestures gammastep kitty lazygit neomutt urlview systemd ipython matplotlib qutebrowser tridactyl

cd garage || exit

# stow -vRt ~ git onedrive neomutt bin vandalfiles
stow --no-folding -vRt ~ git bin vandalfiles neomutt pim onedrive paru taskwarrior 

cd ..
