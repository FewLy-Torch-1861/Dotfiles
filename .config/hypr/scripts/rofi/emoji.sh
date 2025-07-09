#!/bin/bash

pkill rofi || true

rofi -modes "emoji" -i -show emoji -config "$HOME/.config/rofi/config-emoji.rasi" -no-show-icons
