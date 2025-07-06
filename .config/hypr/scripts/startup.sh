#!/bin/bash

# Variable
BROWSER=${1:-brave}

# Start necessary service
/usr/lib/xdg-desktop-portal-gtk &
systemctl --user start hyprpolkitagent &

# Clipboard
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

# Maxout brightness and Apply Gtk settings (just in case)
brightnessctl -q s 100% &
nwg-look -a &

syncthing & # To yeah syncthing
hypridle & # Just do things when you idle
swww-daemon & # WALLPAPER!
swaync & # The Notification daemon
waybar & # The Status bar

discord & # !TRASH-APP
$BROWSER & # I'm just to lazy to press SUPER + B

sleep 5

hyprctl -q dispatch workspace 2 # Go to my most used workspace
