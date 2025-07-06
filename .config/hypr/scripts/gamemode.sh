#!/bin/bash

set -euo pipefail

case "$1" in
yes)
  hyprctl keyword decoration:blur:enabled false
  hyprctl keyword decoration:shadow:enabled false
  hyprctl keyword animations:enabled false
  hyprctl keyword decoration:active_opacity 1
  hyprctl keyword decoration:inactive_opacity 1
  hyprctl keyword decoration:fullscreen_opacity 1
  hyprctl keyword plugin:dynamic-cursors:enabled false

  pkill hypridle

  # swaync-client -dn

  notify-send "Hyprland" "Enabled gamemode"
  ;;
no)
  $HOME/.config/hypr/scripts/reload.sh

  # swaync-client -df

  notify-send "Hyprland" "Disabled gamemode"
  ;;
esac
