#!/bin/bash

pkill rofi || true

scriptDir="${HOME}/.config/hypr/scripts"
rofi_command="rofi -i -dmenu -no-show-icons -config "$HOME/.config/rofi/config-normal.rasi""
settings=(
  " Config"
  " Game mode"
  "󱩌 Night light"
  "󰑓 Reload"
  " Wallpaper"
  " Wi-Fi"
  " Wipe Clipboard"
)

setting_selection=$(for i in "${settings[@]}"; do echo $i; done | sort | $rofi_command -p " Settings")
actual_selection=$(echo "$setting_selection" | sed 's/^[^ ]* //')

case "$actual_selection" in
"Config")
  kitty --hold nvim ~/.config/hypr/hyprland.conf &
  ;;
"Game mode")
  "${scriptDir}/rofi/gamemode.sh"
  ;;
"Night light")
  "${scriptDir}/rofi/night-light.sh"
  ;;
"Reload")
  "${scriptDir}/reload.sh"
  ;;
"Wallpaper")
  "${scriptDir}/rofi/wallpaper.sh"
  ;;
"Wi-Fi")
  "${scriptDir}/rofi/wifi.sh"
  ;;
"Wipe Clipboard")
  cliphist wipe
  notify-send "Hyprland" "Wiped clipboard histories"
  "${scriptDir}/rofi/clipboard.sh"
  ;;
*)
  echo "No match for: $actual_selection" >&2
  exit 1
  ;;
esac
