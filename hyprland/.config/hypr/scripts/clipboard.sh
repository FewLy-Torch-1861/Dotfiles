#!/usr/bin/env bash

pkill fuzzel || true
cliphist list | fuzzel --dmenu --prompt '>w< ' --width 50 --with-nth 2 | cliphist decode | wl-copy
