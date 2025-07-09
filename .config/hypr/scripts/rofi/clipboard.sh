#!/bin/bash

pkill rofi || true

ARGS={1:-}

clipboard() {
  cliphist list | rofi -config "$HOME/.config/rofi/config-normal.rasi" -i -dmenu -no-show-icons -p " Clipboard" -display-columns 2 | cliphist decode | wl-copy
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
