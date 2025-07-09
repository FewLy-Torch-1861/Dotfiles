#!/bin/bash

set -euo pipefail

rofi -modes "emoji" -i -show emoji -config "$HOME/.config/rofi/config-emoji.rasi"
