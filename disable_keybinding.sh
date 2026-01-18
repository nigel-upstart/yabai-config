#!/usr/bin/env bash

# Disable the yabai iTerm quadrant tiling keybinding in skhd

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/config.sh"

# Check if skhd config exists
if [ ! -f "$SKHD_CONFIG" ]; then
    echo "skhd config not found at $SKHD_CONFIG"
    exit 0
fi

# Check if the keybinding exists
if ! grep -q "$MARKER_START" "$SKHD_CONFIG"; then
    echo "Keybinding not found in $SKHD_CONFIG"
    exit 0
fi

# Remove the keybinding block from skhd config
# This removes everything between the markers, including the markers
sed -i.bak "/$MARKER_START/,/$MARKER_END/d" "$SKHD_CONFIG"

echo "✓ Keybinding removed from $SKHD_CONFIG"
echo "  Backup saved at ${SKHD_CONFIG}.bak"
echo ""
echo "Restarting skhd..."

# Restart skhd to apply changes
if pgrep -x skhd > /dev/null; then
    killall skhd
    sleep 0.5
    skhd &
    sleep 0.5
    echo "✓ skhd restarted"
fi

echo ""
echo "Keybinding disabled successfully."
