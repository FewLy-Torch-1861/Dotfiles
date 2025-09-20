#!/usr/bin/env bash

RUN_SCRIPT=$HOME/.config/hypr/scripts/run.sh
MISSIONCENTER=missioncenter
BTOP="kitty -1 --class taskmgr --title "Task Manager" fish -c btop"
HTOP="kitty -1 --class taskmgr --title "Task Manager" fish -c htop"
TOP="kitty -1 --class taskmgr --title "Task Manager" fish -c top"

$RUN_SCRIPT $MISSIONCENTER "$BTOP" "$HTOP" "$TOP"
