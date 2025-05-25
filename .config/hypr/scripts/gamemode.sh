#!/bin/env bash

ENABLE="$1"

case "$ENABLE" in
yes)
  hyprctl keyword decoration:blur:enabled false
  hyprctl keyword decoration:shadow:enabled false
  hyprctl keyword decoration:active_opacity 1
  hyprctl keyword decoration:inactive_opacity 1
  hyprctl keyword decoration:fullscreen_opacity 1
  ;;
no)
  $HOME/.config/hypr/scripts/reload.sh
  ;;
*)
  notify-send "gamemode.sh" "Invalid arg"
  ;;
esac
