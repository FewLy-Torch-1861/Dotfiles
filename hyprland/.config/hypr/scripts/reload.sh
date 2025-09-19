#!/usr/bin/env bash

swww kill || true; swww-daemon&
pkill waybar || true; waybar&
makoctl reload&
hyprctl reload&
