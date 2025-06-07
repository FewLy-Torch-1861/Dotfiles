#!/bin/bash

set -euo pipefail

OUTPUTFOLDER="$HOME/Pictures/Screenshots"

case "$1" in
output)
  hyprshot -m output -m active -o $OUTPUTFOLDER
  ;;
window)
  hyprshot -m window -o $OUTPUTFOLDER
  ;;
region)
  hyprshot -m region -o $OUTPUTFOLDER
  ;;
esac
