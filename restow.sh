#!/usr/bin/bash

# stow -vRt --no-folding ~ nvim bin applications shell kitty task matplotlib neomutt
stow -vRt ~ nvim
stow --no-folding -vRt ~ bin bash tridactyl sway wezterm kitty zsh gammastep waybar qutebrowser lazygit swaylock kanshi libinput-gestures neomutt systemd ipython mako matplotlib zathura nautilus kmonad hypr

cd garage || exit

# stow -vRt ~ git onedrive neomutt bin vandalfiles
stow --no-folding -vRt ~ git bin vandalfiles neomutt pim onedrive paru taskwarrior 

cd ..
