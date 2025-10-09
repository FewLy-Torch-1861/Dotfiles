#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

TMP_FILE=$(mktemp -t "yazi-chooser.XXXXXX")
yazi "${WALLPAPER_DIR}" --chooser-file="${TMP_FILE}"
WALL_PATH=$(cat "${TMP_FILE}")

swww img --transition-type wipe --transition-fps 60 "${WALL_PATH}"
ln -sf "${WALL_PATH}" "$HOME"/.current_wall
