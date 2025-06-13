#!/bin/bash

set -euo pipefail

yay -Syyu
flatpak update
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -a -m "update"

exit 0
