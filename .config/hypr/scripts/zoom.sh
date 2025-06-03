#!/bin/env bash

set -euo pipefail

arg="$1"

case "$arg" in
in)
  hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')
  ;;
out)
  hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')
  ;;
reset)
  hyprctl -q keyword cursor:zoom_factor 1
  ;;
*)
  notify-send "zoom.sh" "Invalid arg"
  ;;
esac
