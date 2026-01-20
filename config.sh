#!/usr/bin/env bash

# Configuration for yabai iTerm quadrant tiling

# Default keybindings
# cmd + 4: Tile first 4 iTerm windows (1-4)
# cmd + shift + 5: Tile next 4 iTerm windows (5-8)
KEYBINDING_1="${KEYBINDING_1:-cmd - 4}"
KEYBINDING_2="${KEYBINDING_2:-cmd + shift - 5}"

# Alternative if conflicts exist:
# KEYBINDING_1="cmd + shift - 4"
# KEYBINDING_2="cmd + alt - 5"

# Path to the tiling script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TILE_SCRIPT="${SCRIPT_DIR}/tile_iterm_quadrants.sh"

# skhd config file location
SKHD_CONFIG="${HOME}/.config/skhd/skhdrc"

# Marker comments for identifying our keybinding in skhd config
MARKER_START="# === yabai-iterm-quadrant START ==="
MARKER_END="# === yabai-iterm-quadrant END ==="
