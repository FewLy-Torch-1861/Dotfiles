#!/usr/bin/env bash

chooser_file=$(mktemp -t "yazi-chooser.XXXXXX")

yazi --chooser-file "$chooser_file" "$HOME"/Pictures/Wallpapers

if [[ -s "$chooser_file" ]]; then
    selected_file=$(<"$chooser_file")
    echo "Setting wallpaper to: $selected_file"
    swww img --transition-type wipe --transition-angle 30 --transition-step 255 --transition-fps 60 "$selected_file"
else
    echo "No file selected."
fi

rm -f "$chooser_file"
