#!/bin/env bash

set -euo pipefail

ENABLE="$1"

case "$ENABLE" in
yes)
  hyprctl keyword decoration:blur:enabled false
  hyprctl keyword decoration:shadow:enabled false
  hyprctl keyword animations:enabled false
  hyprctl keyword decoration:active_opacity 1
  hyprctl keyword decoration:inactive_opacity 1
  hyprctl keyword decoration:fullscreen_opacity 1

  pkill hypridle

  swaync-client -dn

  notify-send -a "hyprland" "Hyprland" "Enabled gamemode"
  ;;
no)
  $HOME/.config/hypr/scripts/reload.sh

  swaync-client -df

  notify-send -a "hyprland" "Hyprland" "Disabled gamemode"
  ;;
*)
  notify-send "gamemode.sh" "Invalid arg"
  ;;
esac
