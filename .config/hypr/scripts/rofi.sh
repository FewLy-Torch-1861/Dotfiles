#!/bin/env bash

set -euo pipefail

if pidof rofi >/dev/null; then
  pkill rofi
fi

MODE="${1:-}"
SUB_CMD="${2:-}"
SEARCH_ENGINE="https://www.google.com/search?q={}"

normal() {
  rofi -show drun
}

web-search() {
  rofi -config "$HOME/.config/rofi/config-web-search.rasi" -dmenu -p " Google" | xargs -I{} xdg-open $SEARCH_ENGINE
  hyprctl dispatch workspace 1
}

clipboard() {
  cliphist list | rofi -config "$HOME/.config/rofi/config-clip.rasi" -i -dmenu -p " Clipboard" -display-columns 2 | cliphist decode | wl-copy
}

emoji() {
  rofi -modes "emoji" -i -show emoji -config "$HOME/.config/rofi/config-emoji.rasi"
}

case "$MODE" in
n)
  normal
  ;;
w)
  web-search
  ;;
c)
  case "$SUB_CMD" in
  wipe)
    cliphist wipe
    clipboard
    ;;
  *)
    clipboard
    ;;
  esac
  ;;
e)
  emoji
  ;;
*)
  notify-send "rofi.sh" "Invalid arg"
  ;;
esac
