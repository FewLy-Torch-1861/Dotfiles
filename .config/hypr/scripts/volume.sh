#!/bin/env bash

set -euo pipefail

replace_file="/tmp/center-notify-id"

get_volume() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}'
}

get_mute() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "Muted" || echo "Unmuted"
}

get_mic_mute() {
  wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo "Muted" || echo "Unmuted"
}

notify() {
  local message="$1"
  local volume=$(get_volume)

  if [[ -s "$replace_file" && $(cat "$replace_file") =~ ^[0-9]+$ ]]; then
    replace_id=$(cat "$replace_file")
  else
    replace_id=0
  fi

  new_id=$(notify-send -p -e -r "$replace_id" -t 1000 -a "status-notif" -h int:value:"$volume" -u low "$message")
  echo "$new_id" >"$replace_file"
}

case "$1" in
inc)
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
  notify "Volume: $(get_volume)%"
  ;;
dec)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  notify "Volume: $(get_volume)%"
  ;;
linc)
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+
  notify "Volume: $(get_volume)%"
  ;;
ldec)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
  notify "Volume: $(get_volume)%"
  ;;
mute)
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  status=$(get_mute)
  notify "$status"
  ;;
mute-mic)
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
  status=$(get_mic_mute)
  notify "$status"
  ;;
*)
  notify-send "volume.sh" "Invalid arg"
  ;;
esac
