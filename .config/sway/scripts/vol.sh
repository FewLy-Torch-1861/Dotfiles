#!/usr/bin/env bash

MODE=$1
STEP=${2:-5}
SPEAKER="@DEFAULT_AUDIO_SINK@"
MIC="@DEFAULT_AUDIO_SOURCE@"

get-status() {
  VOLUME=$(wpctl get-volume "$1")
  if ! echo "$VOLUME" | grep -q MUTED; then
    echo "$VOLUME" | awk '{print int($2 * 100)}'
  else
    echo muted
  fi
}

notify() {
  if [[ "$2" != "muted" ]]; then
    notify-send \
      -e \
      -t 1000 \
      -a osd \
      -h int:value:"$2" \
      "$1: ${2:-}"
  else
    notify-send \
      -e \
      -t 1000 \
      -a osd \
      "$1: Muted"
  fi
}

case $MODE in
up)
  wpctl set-volume $SPEAKER "$STEP"%+
  notify "Volume" "$(get-status $SPEAKER)%"
  ;;
dn)
  wpctl set-volume $SPEAKER "$STEP"%-
  notify "Volume" "$(get-status $SPEAKER)%"
  ;;
ms)
  wpctl set-mute $SPEAKER "$STEP"
  notify "Volume" "$(get-status $SPEAKER)"
  ;;
mm)
  wpctl set-mute $MIC "$STEP"
  notify "Mic" "$(get-status $MIC)"
  ;;
esac
