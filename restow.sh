#!/usr/bin/bash

# Generic
#stow -vRt ~ shell bin applications nvim tridactyl ipython neomutt task systemd qutebrowser urlview chromium tmux libinput-gestures jupyterlab zathura flake8

stow -vRt ~ shell ipython nvim bin tridactyl applications systemd task qutebrowser urlview chromium tmux libinput-gestures jupyterlab zathura flake8 neomutt matplotlib kitty

# For sway
#stow -vRt ~ sway waybar mako defaults alacritty kitty libinput-gestures swaylock kanshi gammastep wofi
stow -vRt ~ kanshi mako waybar swaylock gammastep libinput-gestures

cd garage || exit

stow -vRt ~ neomutt rbw newsboat pim git zoom onedrive spotifyd

cd ..
