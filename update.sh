#!/bin/bash

set -euo pipefail

echo "[*] Updating pacman and aur..."

yay -Syyu

echo "[*] Updating flatpak..."

flatpak update

echo "[*] Commiting dotfiles change..."

/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -a -m "update"

echo "[*] Doned exiting..."

exit 0
