#!/usr/bin/env bash

# Configuration for yabai iTerm quadrant tiling

# Default keybinding (cmd + 4)
# If this conflicts, uncomment the line below to use cmd + shift + 4
KEYBINDING="${KEYBINDING:-cmd - 4}"
# KEYBINDING="cmd + shift - 4"

# Path to the tiling script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TILE_SCRIPT="${SCRIPT_DIR}/tile_iterm_quadrants.sh"

# skhd config file location
SKHD_CONFIG="${HOME}/.config/skhd/skhdrc"

# Marker comments for identifying our keybinding in skhd config
MARKER_START="# === yabai-iterm-quadrant START ==="
MARKER_END="# === yabai-iterm-quadrant END ==="
