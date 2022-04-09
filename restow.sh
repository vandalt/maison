#!/usr/bin/bash

# Generic
stow -vRt ~ shell bin applications nvim tridactyl ipython task neomutt systemd qutebrowser urlview chromium tmux libinput-gestures jupyterlab zathura flake8

# For sway
stow -vRt ~ sway waybar mako defaults alacritty kitty libinput-gestures swaylock kanshi gammastep wofi

cd garage

stow -vRt ~ neomutt rbw newsboat pim git zoom onedrive

cd ..
