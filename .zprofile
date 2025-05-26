if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec hyprland
fi

# if uwsm check may-start && uwsm select; then
#   exec uwsm start default
# fi
