#!/bin/bash

rofi_command="rofi -i -dmenu -no-show-icons -config ${HOME}/.config/rofi/config-toggle.rasi"
toggle=(
  " Enabled"
  " Disabled"
)

selection=$(for i in "${toggle[@]}"; do echo "$i"; done | ${rofi_command} -p " Gamemode")
actual_selection=$(echo "$selection" | sed 's/^[^ ]* //')

case "$actual_selection" in
Enabled)
  hyprctl keyword decoration:blur:enabled false
  hyprctl keyword decoration:shadow:enabled false
  hyprctl keyword animations:enabled false
  hyprctl keyword decoration:active_opacity 1
  hyprctl keyword decoration:inactive_opacity 1
  hyprctl keyword decoration:fullscreen_opacity 1
  hyprctl keyword plugin:dynamic-cursors:enabled false

  pkill hypridle

  notify-send "Hyprland" "Enabled gamemode"
  ;;
Disabled)
  "$HOME/.config/hypr/scripts/reload.sh"

  notify-send "Hyprland" "Disabled gamemode"
  ;;
*)
  echo "No match for: $actual_selection" >&2
  exit 1
  ;;
esac
