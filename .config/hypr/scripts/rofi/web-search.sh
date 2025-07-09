#!/bin/bash

pkill rofi || true

SEARCH_ENGINE="https://www.google.com/search?q={}"

rofi -config "$HOME/.config/rofi/config-prompt.rasi" -dmenu -p "oogle" | xargs -I{} xdg-open $SEARCH_ENGINE
