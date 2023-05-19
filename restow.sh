#!/usr/bin/bash

# stow -vRt --no-folding ~ nvim bin applications shell kitty task matplotlib neomutt
stow --no-folding -vRt ~ bin bash tridactyl kitty zsh

cd garage || exit

# stow -vRt ~ git onedrive neomutt bin vandalfiles
stow --no-folding -vRt ~ git bin vandalfiles

cd ..
