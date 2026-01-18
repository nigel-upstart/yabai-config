#!/usr/bin/env bash

# Enable the yabai iTerm quadrant tiling keybinding in skhd

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/config.sh"

# Ensure skhd config directory exists
mkdir -p "$(dirname "$SKHD_CONFIG")"

# Check if the keybindings already exist
if [ -f "$SKHD_CONFIG" ] && grep -q "$MARKER_START" "$SKHD_CONFIG"; then
    echo "Keybindings already exist in $SKHD_CONFIG"
    echo "Current keybindings:"
    echo "  $KEYBINDING_1 - Tile windows 1-4"
    echo "  $KEYBINDING_2 - Tile windows 5-8"
    exit 0
fi

# Create skhd config if it doesn't exist
if [ ! -f "$SKHD_CONFIG" ]; then
    touch "$SKHD_CONFIG"
    echo "Created new skhd config at $SKHD_CONFIG"
fi

# Add the keybindings to skhd config
cat >> "$SKHD_CONFIG" << EOF

$MARKER_START
# Tile first 4 iTerm windows into quadrants (windows 1-4)
$KEYBINDING_1 : "$TILE_SCRIPT" 0

# Tile next 4 iTerm windows into quadrants (windows 5-8)
$KEYBINDING_2 : "$TILE_SCRIPT" 4
$MARKER_END
EOF

echo "✓ Keybindings added to $SKHD_CONFIG"
echo "  $KEYBINDING_1 - Tile windows 1-4"
echo "  $KEYBINDING_2 - Tile windows 5-8"
echo "  Script: $TILE_SCRIPT"
echo ""
echo "Restarting skhd..."

# Restart skhd to apply changes
if pgrep -x skhd > /dev/null; then
    killall skhd
    sleep 0.5
fi

skhd &
sleep 0.5

if pgrep -x skhd > /dev/null; then
    echo "✓ skhd started"
else
    echo "✗ Failed to start skhd. Try running: skhd &"
    exit 1
fi

echo ""
echo "Setup complete!"
echo "  Press $KEYBINDING_1 to tile iTerm windows 1-4"
echo "  Press $KEYBINDING_2 to tile iTerm windows 5-8"
