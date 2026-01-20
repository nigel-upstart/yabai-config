# Yabai iTerm Quadrant Tiling

Automatically tile the first 4 iTerm2 windows into a 2×2 quadrant layout using yabai and skhd, while keeping yabai in float mode.

## Features

- 🎯 **Simple quadrant tiling** - Tile first 4 iTerm windows with one keystroke
- 🎨 **Float mode compatible** - No need to switch to BSP layout
- ⌨️ **One-handed keybinding** - `⌘4` (configurable)
- 🔧 **Easy enable/disable** - Simple scripts to manage keybinding
- 📦 **Self-contained** - All configuration in this repo
- 🪟 **Global hotkey** - Works from any application, brings iTerm to front

## Prerequisites

Install via Homebrew if not already installed:

```bash
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install jq
```

Grant Accessibility permissions to both yabai and skhd in:
**System Settings → Privacy & Security → Accessibility**

## Quick Start

### 1. Enable the Keybinding

```bash
./enable_keybinding.sh
```

This will:
- Add the keybinding to `~/.config/skhd/skhdrc`
- Start or restart skhd
- Default keybinding: `⌘4`

### 2. Use It

Open at least 4 iTerm2 windows, then press `⌘4` (from any application):

```
┌─────────┬─────────┐
│ Window 1│ Window 2│
├─────────┼─────────┤
│ Window 3│ Window 4│
└─────────┴─────────┘
```

The first 4 windows are selected by most-recently-focused order, and iTerm is brought to the front automatically.

### 3. Disable (Optional)

To remove the keybinding:

```bash
./disable_keybinding.sh
```

## Configuration

### Change the Keybinding

Edit `config.sh` and set your preferred keybinding:

```bash
# Default: cmd + 4
KEYBINDING="cmd - 4"

# Alternative: cmd + shift + 4
# KEYBINDING="cmd + shift - 4"
```

Then run `./enable_keybinding.sh` again to apply.

### skhd Keybinding Format

- `cmd` - Command key
- `shift` - Shift key
- `-` separator between modifier and key
- Example: `cmd + shift - 4` = Command + Shift + 4

See [skhd documentation](https://github.com/koekeishiya/skhd) for more options.

## Manual Usage

You can also run the tiling script directly without a keybinding:

```bash
# Tile first 4 windows
./tile_iterm_quadrants.sh

# Or specify an offset to tile different windows
# Tile windows 5-8
./tile_iterm_quadrants.sh 4
```

## How It Works

The `tile_iterm_quadrants.sh` script:

1. Accepts an optional offset parameter (default: 0)
2. Queries all windows using `yabai -m query --windows`
3. Filters for iTerm2 application windows
4. Skips the first N windows (where N is the offset)
5. Takes the next 4 window IDs
6. Places each in a quadrant using yabai's grid format:
   - Top-left: `2:2:0:0:1:1`
   - Top-right: `2:2:1:0:1:1`
   - Bottom-left: `2:2:0:1:1:1`
   - Bottom-right: `2:2:1:1:1:1`

The grid format is `rows:cols:start-x:start-y:width:height`, where the screen is divided into a 2×2 grid and each window occupies one cell.

**Window Ordering:** Windows are returned by yabai in most-recently-focused order (see [yabai issue #944](https://github.com/koekeishiya/yabai/issues/944)), so the "first 4" windows are the 4 most recently active windows.

## Troubleshooting

### Keybinding not working

1. Check if skhd is running: `pgrep skhd`
2. Restart skhd manually: `killall skhd && skhd &`
3. Verify keybinding: `cat ~/.config/skhd/skhdrc`
4. Make sure you've added the **actual binary** to Accessibility:
   - Find the real path: `ls -la /opt/homebrew/bin/skhd`
   - Add `/opt/homebrew/Cellar/skhd/VERSION/bin/skhd` to Accessibility permissions

### Accessibility permissions

Make sure both yabai and skhd have Accessibility permissions:
- System Settings → Privacy & Security → Accessibility
- Add `/opt/homebrew/bin/yabai`
- Add `/opt/homebrew/bin/skhd`

### Windows not tiling

1. Verify yabai is running: `yabai -m query --windows`
2. Check you have at least 1 iTerm window open
3. Run the script manually to see error messages: `./tile_iterm_quadrants.sh`

## Project Structure

```
.
├── README.md                    # This file
├── CLAUDE.md                    # Project documentation for Claude
├── config.sh                    # Configuration (keybinding, paths)
├── tile_iterm_quadrants.sh      # Main tiling script
├── enable_keybinding.sh         # Add keybinding to skhd
└── disable_keybinding.sh        # Remove keybinding from skhd
```

## Resources

- [yabai Wiki](https://github.com/koekeishiya/yabai/wiki)
- [yabai Commands](https://github.com/koekeishiya/yabai/wiki/Commands)
- [skhd Documentation](https://github.com/koekeishiya/skhd)
- [Josh Medeski's Yabai Guide](https://www.joshmedeski.com/posts/blazing-fast-window-management-on-macos/)
- [Josean's Yabai Setup](https://www.josean.com/posts/yabai-setup)

## License

MIT
