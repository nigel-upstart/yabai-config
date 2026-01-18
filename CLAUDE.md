# Yabai iTerm Quadrant Tiling Configuration

## Project Overview

This project provides scripting to tile the first four iTerm windows into a 2x2 quadrant layout using yabai window manager. The solution maintains yabai's `float` layout mode while providing explicit grid placement for precise window positioning.

## Key Features

- **Float Mode Compatibility**: Uses yabai's grid placement without switching to BSP layout
- **Batch Window Tiling**: Support for tiling up to 8 windows across two batches
- **Dual Keybindings**: Command+4 for windows 1-4, Command+5 for windows 5-8
- **Enable/Disable Scripts**: Easy scripts to add or remove the keybindings
- **One-Handed Operation**: Keybindings designed for single-hand activation
- **Offset-Based Selection**: Script accepts offset parameter for flexible window selection

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
   - Accepts optional offset parameter (0 for windows 1-4, 4 for windows 5-8)
2. **enable_keybinding.sh**: Adds both keybindings to skhd configuration
3. **disable_keybinding.sh**: Removes the keybindings from skhd configuration
4. **config.sh**: Configuration file for keybindings and paths
5. **setup_skhd_autostart.sh**: Sets up skhd to start automatically via LaunchAgent

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

## Window Ordering

Windows returned by `yabai -m query --windows` are in **most-recently-focused order** (see [yabai issue #944](https://github.com/koekeishiya/yabai/issues/944)). This means:
- The "first 4" windows are the 4 most recently used/focused
- Windows 5-8 are the next 4 most recently used
- Ordering changes as you switch between windows

## References

Key documentation sources:
- [Yabai Commands Wiki](https://github.com/koekeishiya/yabai/wiki/Commands)
- [Yabai Configuration Wiki](https://github.com/koekeishiya/yabai/wiki/Configuration)
- [Josh Medeski's Yabai Setup](https://www.joshmedeski.com/posts/blazing-fast-window-management-on-macos/)
- [Yabai Window Ordering Discussion](https://github.com/koekeishiya/yabai/issues/944)
