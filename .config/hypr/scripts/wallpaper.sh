#!/bin/env bash

set -euo pipefail

# Set some variables
wall_dir="${HOME}/Pictures/Wallpapers"
cacheDir="${HOME}/.cache/wallpaper"
rofi_command="rofi -i -dmenu -theme ${HOME}/.config/rofi/config-wall.rasi"

replace_file="/tmp/center-notify-id"

notify() {
  local headler="$1"
  local message="$2"

  if [[ -s "$replace_file" && $(cat "$replace_file") =~ ^[0-9]+$ ]]; then
    replace_id=$(cat "$replace_file")
  else
    replace_id=0
  fi

  new_id=$(notify-send -p -e -r "$replace_id" -t 500 -a "status-notif" -u low "$headler" "$message")
  echo "$new_id" >"$replace_file"
}

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ]; then
  mkdir -p "${cacheDir}"
fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
  if [ -f "$imagen" ]; then
    nombre_archivo=$(basename "$imagen")
    if [ ! -f "${cacheDir}/${nombre_archivo}" ]; then
      magick "$imagen" -strip -thumbnail 720x405^ -gravity center -extent 720x405 "${cacheDir}/${nombre_archivo}"

      # echo "Converting: $imagen"
      notify "wallpaper.sh" "Converting: $imagen"
    fi
  fi
done

# Select a picture with rofi
wall_selection=$(find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A; do echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n"; done | $rofi_command)

# Set the wallpaper
[[ -n "$wall_selection" ]] || exit 1
swww img -t outer --transition-duration 1.5 --transition-step 255 --transition-fps 60 -f Nearest "${wall_dir}/${wall_selection}"
matugen image -t "scheme-content" "${wall_dir}/${wall_selection}"
ln -sf "${wall_dir}/${wall_selection}" "${HOME}/.currentwall"
sleep 1s
~/.config/hypr/scripts/reload.sh

exit 0
