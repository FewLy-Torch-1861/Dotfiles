#!/usr/bin/env bash

RECORD_PATH="${1:-$HOME/Videos/Record}"

if [[ -n $RECORD_PATH ]]; then
  if pgrep -x gpu-screen-reco >/dev/null; then
    pkill -INT gpu-screen-reco
    notify-send "Screen Recording Stopped"
  else
    notify-send "Screen Recording Started"
    gpu-screen-recorder \
      -w screen \
      -f 60 \
      -a default_output \
      -o "${RECORD_PATH}/Record-$(date +%y-%m-%d-%H-%M-%S).mp4"
  fi
else
  echo "Usage: $0 [path]"
  exit 1
fi

case $1 in
-h | --help)
  echo "Usage: $0 [path]"
  exit 1
  ;;
esac
