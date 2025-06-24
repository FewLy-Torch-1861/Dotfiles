#!/bin/bash

set -euo pipefail

replace_file="/tmp/kb-notify-id"

get_layout() {
  hyprctl devices -j |
    jq -r '.keyboards[] | .active_keymap' |
    head -n1 |
    cut -c1-2 |
    tr 'a-z' 'A-Z'
}

switch_layout() {
  hyprctl \
    --batch "$(
      hyprctl devices -j |
        jq -r '.keyboards[] | .name' |
        while IFS= read -r keyboard; do
          printf '%s %s %s;' 'switchxkblayout' "${keyboard}" 'next'
        done
    )"
}

notify() {
  if [[ -s "$replace_file" && $(cat "$replace_file") =~ ^[0-9]+$ ]]; then
    replace_id=$(cat "$replace_file")
  else
    replace_id=0
  fi

  new_id=$(notify-send -p -e -r "$replace_id" -t 1000 -u low "$1" "$2")
  echo "$new_id" >"$replace_file"
}

switch_layout

case "$(get_layout)" in
EN)
  notify "⌨️ Keyboard Layout" "🇺🇸 English (US)"
  ;;
TH)
  notify "⌨️ Keyboard Layout" "🇹🇭 Thai"
  ;;
esac
