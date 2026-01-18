# Yabai iTerm Quadrant Tiling Configuration

## Project Overview

This project provides scripting to tile the first four iTerm windows into a 2x2 quadrant layout using yabai window manager. The solution maintains yabai's `float` layout mode while providing explicit grid placement for precise window positioning.

## Key Features

- **Float Mode Compatibility**: Uses yabai's grid placement without switching to BSP layout
- **Configurable Keybinding**: Default keybinding is Command+4 (or Command+Shift+4 if conflicts exist)
- **Enable/Disable Scripts**: Easy scripts to add or remove the keybinding
- **One-Handed Operation**: Keybinding designed for single-hand activation

## Architecture

### Grid Placement Format

Yabai uses the format `<rows>:<cols>:<start-x>:<start-y>:<width>:<height>` for grid placement:
- For 2x2 quadrant layout:
  - Top-left: `2:2:0:0:1:1`
  - Top-right: `2:2:1:0:1:1`
  - Bottom-left: `2:2:0:1:1:1`
  - Bottom-right: `2:2:1:1:1:1`

### Components

1. **tile_iterm_quadrants.sh**: Main script that queries iTerm windows and places them in quadrants
2. **enable_keybinding.sh**: Adds the keybinding to skhd configuration
3. **disable_keybinding.sh**: Removes the keybinding from skhd configuration
4. **config.sh**: Configuration file for keybinding and paths

## Requirements

- macOS with Accessibility permissions granted
- yabai (installed via Homebrew)
- skhd (installed via Homebrew)
- iTerm2
- jq (for JSON parsing)

## Installation Notes

- Yabai version: v7.1.16+
- Works with default float layout
- No SIP disabling required for this functionality

## References

Key documentation sources:
- [Yabai Commands Wiki](https://github.com/koekeishiya/yabai/wiki/Commands)
- [Yabai Configuration Wiki](https://github.com/koekeishiya/yabai/wiki/Configuration)
- [Josh Medeski's Yabai Setup](https://www.joshmedeski.com/posts/blazing-fast-window-management-on-macos/)
