#!/usr/bin/env bash

swww kill || true
swww-daemon&

pkill waybar || true
waybar&

pkill hypridle || true
hypridle&

pkill hyprsunset || true
sleep 1 && hyprsunset&

makoctl reload&
hyprctl reload&
