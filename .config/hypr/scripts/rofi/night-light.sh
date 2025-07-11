#!/bin/bash

pkill rofi || true

rofi_command="rofi -i -dmenu -no-show-icons -config ${HOME}/.config/rofi/config-toggle.rasi"
toggle=(
  " Enabled"
  " Disabled"
)

selection=$(for i in "${toggle[@]}"; do echo "$i"; done | ${rofi_command} -p "󱩌 Night light")
actual_selection=$(echo "$selection" | sed 's/^[^ ]* //')

case "$actual_selection" in
Enabled)
  hyprsunset -t 5000 &

  notify-send "Hyprland" "Enabled night light"
  ;;
Disabled)
  pkill hyprsunset

  notify-send "Hyprland" "Disabled night light"
  ;;
*)
  echo "No match for: $actual_selection" >&2
  exit 1
  ;;
esac
