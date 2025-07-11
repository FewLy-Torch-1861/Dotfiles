#!/bin/bash

# Variable
BROWSER=$1

# Start necessary service
/usr/lib/xdg-desktop-portal-gtk &
systemctl --user start hyprpolkitagent &

# Clipboard
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

# Maxout brightness and Apply Gtk settings (just in case)
brightnessctl -q s 100% &
nwg-look -a &

syncthing &   # To... Yeah syncthing
hypridle &    # Just do things when you idle
swww-daemon & # WALLPAPER!
swaync &      # The Notification daemon
waybar &      # The Status bar

discord &                                                                           # !TRASH-APP
$BROWSER || notify-send -a "Hyprland" "startup.sh" "Startup Browser is not set\!" & # I'm just to lazy to press SUPER + B

sleep 7.5

hyprctl -q dispatch workspace 2 # Go to my most used workspace

kitty -o font_size=35 --class greeting ~/.local/bin/greeting
