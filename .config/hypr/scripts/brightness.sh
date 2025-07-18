#!/bin/bash

set -euo pipefail

replace_file="/tmp/bl-notify-id"

get_brightness() {
  brightnessctl i | grep -oP '(?<=Current brightness: ).*' | awk -F'[()%]' '{ print $2 }'
}

notify() {
  local brightness=$(get_brightness)

  if [[ -s "$replace_file" && $(cat "$replace_file") =~ ^[0-9]+$ ]]; then
    replace_id=$(cat "$replace_file")
  else
    replace_id=0
  fi

  new_id=$(notify-send -p -e -r "$replace_id" -t 1000 -a "brightness" -h int:value:"$brightness" -u low "$1")
  echo "$new_id" >"$replace_file"
}

case "$1" in
inc)
  brightnessctl s 10%+
  notify "🔆 Brightness: $(get_brightness)%"
  ;;
dec)
  brightnessctl s 10%-
  notify "🔅 Brightness: $(get_brightness)%"
  ;;
linc)
  brightnessctl s 1%+
  notify "🔆 Brightness: $(get_brightness)%"
  ;;
ldec)
  brightnessctl s 1%-
  notify "🔅 Brightness: $(get_brightness)%"
  ;;
esac
