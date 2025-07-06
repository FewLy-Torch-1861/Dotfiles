if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  ~/.local/bin/unlock-keyring
  exec Hyprland
fi
