if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec hyprland
fi

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
