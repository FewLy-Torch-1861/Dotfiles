#!/usr/bin/env bash

get-layout() {
  swaymsg -t get_inputs | jq -r ".[] | select(.type == \"keyboard\") | .xkb_active_layout_name" | head -n 1
}

next-layout() {
  swaymsg input type:keyboard xkb_switch_layout next
}

notify() {
  notify-send \
    -e \
    -t 1000 \
    -a osd \
    "$1"
}

next-layout
notify "Layout: $(get-layout)"
