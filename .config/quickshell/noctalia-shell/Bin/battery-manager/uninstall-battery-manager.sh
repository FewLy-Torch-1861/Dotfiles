#!/usr/bin/env bash

SCRIPT_PATH="/usr/bin/battery-manager-nutt"
POLICY_PATH="/usr/share/polkit-1/actions/com.local.battery-manager.nutt.policy"
RULE_PATH="/etc/polkit-1/rules.d/50-battery-manager-nutt.rules"
LOG_PATH="/var/log/battery-manager.log"


if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

echo "Uninstalling battery manager..."

if [ -f "$SCRIPT_PATH" ]; then
    rm -f "$SCRIPT_PATH"
    echo "Removed script from $SCRIPT_PATH"
fi

if [ -f "$POLICY_PATH" ]; then
    rm -f "$POLICY_PATH"
    echo "Removed policy file from $POLICY_PATH"
fi

if [ -f "$RULE_PATH" ]; then
    rm -f "$RULE_PATH"
    echo "Removed udev rule from $RULE_PATH"
fi

if [ -f "$LOG_PATH" ]; then
    rm -f "$LOG_PATH"
    echo "Removed log file from $LOG_PATH"
fi

echo "Uninstallation completed successfully"
