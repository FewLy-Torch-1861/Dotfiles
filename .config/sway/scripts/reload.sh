#!/usr/bin/env bash

makoctl reload
pkill waybar || true; waybar
chmod +x "$HOME"/.config/sway/scripts/*
