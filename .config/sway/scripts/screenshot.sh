#!/usr/bin/env bash
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
SCREENSHOT_FILE="Screenshot-$(date +%y-%m-%d-%H-%M-%S).png"
FULL_PATH="$SCREENSHOT_DIR/$SCREENSHOT_FILE"

mkdir -p "$SCREENSHOT_DIR"

case "$1" in
full)
  grim -t png "$FULL_PATH"
  cat "$FULL_PATH" | wl-copy --type image/png
  notify-send "Screenshot Taken"
  ;;
select)
  if grim -t png -g "$(slurp)" "$FULL_PATH"; then
    cat "$FULL_PATH" | wl-copy --type image/png
    notify-send "Screenshot Taken"
  fi
  ;;
window)
  GEOMETRY=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | "\(.rect.x+.window_rect.x),\(.rect.y+.window_rect.y) \(.window_rect.width)x\(.window_rect.height)"' | slurp)

  if [ -n "$GEOMETRY" ]; then
    grim -t png -g "$GEOMETRY" "$FULL_PATH"
    cat "$FULL_PATH" | wl-copy --type image/png
    notify-send "Screenshot Taken"
  fi
  ;;
-h | --help | *)
  echo "Usage: $0 <full|select|window>"
  exit 1
  ;;
esac
