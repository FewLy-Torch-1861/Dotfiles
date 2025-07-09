#!/bin/bash

set -euo pipefail

SEARCH_ENGINE="https://www.google.com/search?q={}"

rofi -config "$HOME/.config/rofi/config-web-search.rasi" -dmenu -p " Google" | xargs -I{} xdg-open $SEARCH_ENGINE
