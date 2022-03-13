#!/usr/bin/bash

stow -vRt ~ shell bin applications nvim tridactyl ipython task neomutt systemd qutebrowser urlview chromium tmux libinput-gestures jupyterlab

# For sway
#stow -vRt ~ shell bin sway waybar mako defaults alacritty kitty applications libinput-gestures nvim swaylock kanshi tridactyl gammastep ipython task neomutt systemd qutebrowser wofi urlview

cd garage

stow -vRt ~ neomutt rbw newsboat pim git task zoom

cd ..
