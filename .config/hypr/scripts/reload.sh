#!/bin/env bash

set -euo pipefail

restart_service() {
  local service_name="$1"
  pkill "$service_name" || notify-send "$service_name is not running"
  "$service_name" &
}

restart_service "swww-daemon"
restart_service "waybar"
restart_service "hypridle"

if ! hyprctl reload; then
  notify-send "Failed to reload Hyprland configuration"
  exit 1
fi

if ! makoctl reload; then
  notify-send "Failed to reload Mako configuration"
  exit 1
fi

# notify-send -a "Test notif app" -i firefox -t 5000 "Here is some summary" "needed to <s>create</s> that script cuz /usr/bin/makoctl reload wasn't working and was preventing the notification to appear with no logs"

notify-send "All services restarted and Hyprland reloaded successfully."
