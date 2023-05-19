#!/usr/bin/bash

stow -vRt --no-folding ~ nvim bin applications shell kitty task matplotlib neomutt

cd garage || exit

stow -vRt ~ git onedrive neomutt bin vandalfiles

cd ..
