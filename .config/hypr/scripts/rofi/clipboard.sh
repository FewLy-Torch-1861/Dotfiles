#!/bin/bash

set -euo pipefail

ARGS={1:-}

clipboard() {
  cliphist list | rofi -config "$HOME/.config/rofi/config-clip.rasi" -i -dmenu -p " Clipboard" -display-columns 2 | cliphist decode | wl-copy
}

case "$ARGS" in
wipe)
  notify-send "Hyprland" "wiped clipboard histories"
  cliphist wipe
  clipboard
  ;;
*)
  clipboard
  ;;
esac
