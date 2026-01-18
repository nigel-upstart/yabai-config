#!/usr/bin/env bash

# Enable the yabai iTerm quadrant tiling keybinding in skhd

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/config.sh"

# Ensure skhd config directory exists
mkdir -p "$(dirname "$SKHD_CONFIG")"

# Check if the keybinding already exists
if [ -f "$SKHD_CONFIG" ] && grep -q "$MARKER_START" "$SKHD_CONFIG"; then
    echo "Keybinding already exists in $SKHD_CONFIG"
    echo "Current keybinding: $KEYBINDING"
    exit 0
fi

# Create skhd config if it doesn't exist
if [ ! -f "$SKHD_CONFIG" ]; then
    touch "$SKHD_CONFIG"
    echo "Created new skhd config at $SKHD_CONFIG"
fi

# Add the keybinding to skhd config
cat >> "$SKHD_CONFIG" << EOF

$MARKER_START
# Tile first 4 iTerm windows into quadrants
$KEYBINDING : "$TILE_SCRIPT"
$MARKER_END
EOF

echo "✓ Keybinding added to $SKHD_CONFIG"
echo "  Keybinding: $KEYBINDING"
echo "  Script: $TILE_SCRIPT"
echo ""
echo "Restarting skhd..."

# Restart skhd to apply changes
if pgrep -x skhd > /dev/null; then
    brew services restart skhd
    echo "✓ skhd restarted"
else
    brew services start skhd
    echo "✓ skhd started"
fi

echo ""
echo "Setup complete! Press $KEYBINDING to tile your first 4 iTerm windows."
