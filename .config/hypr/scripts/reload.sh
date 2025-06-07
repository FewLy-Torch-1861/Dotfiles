#!/bin/bash

set -euo pipefail

restart_service() {
  local service_name="$1"
  pkill "$service_name" || notify-send "$service_name is not running"
  "$service_name" &
}

restart_service "swww-daemon"
restart_service "swaync"
# restart_service "waybar"
restart_service "hypridle"

if ! hyprctl reload; then
  notify-send "Failed to reload Hyprland configuration"
  exit 1
fi

notify-send "Hyprland" "All services restarted and Hyprland reloaded successfully."
