#!/bin/env bash

arg="$1"
replace_file="/tmp/center-notify-id"

get_brightness() {
  brightnessctl i | grep -oP '(?<=Current brightness: ).*' | awk -F'[()%]' '{ print $2 }'
}

notify() {
  local message="$1"
  local brightness=$(get_brightness)

  if [[ -s "$replace_file" && $(cat "$replace_file") =~ ^[0-9]+$ ]]; then
    replace_id=$(cat "$replace_file")
  else
    replace_id=0
  fi

  new_id=$(notify-send -p -e -r "$replace_id" -t 1000 -a "status-notif" -h int:value:"$brightness" -u low "$message")
  echo "$new_id" >"$replace_file"
}

case "$arg" in
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
*)
  notify-send "volume.sh" "Invalid arg"
  ;;
esac
