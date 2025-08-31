#!/usr/bin/env bash

# A script to apply a new pywal theme to all relevant applications.
# This script is intended to be called by another program (like waypaper)
# that provides the path to the new wallpaper as the first argument.

set -e

if [ -z "$1" ]; then
    echo "No wallpaper path provided. Won't update pywal and walcord colors."
else
	WALLPAPER_PATH="$1"
	echo "Setting new theme from: $WALLPAPER_PATH"
	wal -q -i "$WALLPAPER_PATH"
fi

echo "Reloading Wayland notification daemon..."
swaync-client -rs

echo "Reloading Waybar for new theme..."
pkill waybar && waybar &

echo "==> Theme update complete!"
