#!/usr/bin/env bash

MODE=$1
STEP=${2:-5}

get-brightness() {
  brightnessctl | grep -oP "(\d{0,3})(?=%)"
}

notify() {
  notify-send \
    -e \
    -t 1000 \
    -a osd \
    -h int:value:"$2" \
    "$1: ${2:-}"
}

case $MODE in
up)
  brightnessctl s +"$STEP"%
  notify "Brightness" "$(get-brightness)"
  ;;
dn)
  if [[ "$(( $(get-brightness) - STEP ))" -ge 1 ]]; then
    brightnessctl s "$STEP"%-
    notify "Brightness" "$(get-brightness)"
  else
    brightnessctl s 1%
    notify "Brightness" "$(get-brightness)"
  fi
  ;;
esac
