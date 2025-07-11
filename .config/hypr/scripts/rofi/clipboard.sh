#!/bin/bash

pkill rofi || true

cliphist list | rofi -config "$HOME/.config/rofi/config-normal.rasi" -i -dmenu -no-show-icons -p " Clipboard" -display-columns 2 | cliphist decode | wl-copy
