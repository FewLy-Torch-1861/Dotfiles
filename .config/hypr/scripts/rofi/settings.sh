#!/bin/bash

pkill rofi || true

scriptDir="${HOME}/.config/hypr/scripts"
rofi_command="rofi -i -dmenu -no-show-icons -config "$HOME/.config/rofi/config-normal.rasi""
settings=(
  " Wallpaper"
  " Wi-Fi"
)

setting_selection=$(for i in "${settings[@]}"; do echo $i; done | sort | $rofi_command -p " Settings")
actual_selection=$(echo "$setting_selection" | sed 's/^[^ ]* //')

case "$actual_selection" in
"Wallpaper")
  ${scriptDir}/rofi/wallpaper.sh
  ;;
"Wi-Fi")
  ${scriptDir}/rofi/wifi.sh
  ;;
*)
  echo "No match for: $actual_selection" >&2
  exit 1
  ;;
esac
