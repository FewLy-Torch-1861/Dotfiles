#!/bin/bash

color=$(cat ~/.config/hypr/colors.conf | grep \$primary_hex | awk '{ print $3 }')
current_hour=$(date +"%H")
user_string="<span color='#$color'>$USER</span>"

if [ "$current_hour" -ge 5 ] && [ "$current_hour" -lt 11 ]; then
  echo "Good morning, $user_string"
elif [ "$current_hour" -ge 11 ] && [ "$current_hour" -lt 17 ]; then
  echo "Good day, $user_string"
elif [ "$current_hour" -ge 17 ] && [ "$current_hour" -lt 19 ]; then
  echo "Good evening, $user_string"
else
  echo "Good night, $user_string"
fi
