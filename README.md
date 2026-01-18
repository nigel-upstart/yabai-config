# Yabai iTerm Quadrant Tiling

Automatically tile iTerm2 windows into a 2×2 quadrant layout using yabai and skhd, while keeping yabai in float mode.

## Features

- 🎯 **Batch quadrant tiling** - Tile up to 8 iTerm windows across two layouts
- 🎨 **Float mode compatible** - No need to switch to BSP layout
- ⌨️ **Dual keybindings** - `⌘4` for windows 1-4, `⌘5` for windows 5-8
- 🔧 **Easy enable/disable** - Simple scripts to manage keybindings
- 📦 **Self-contained** - All configuration in this repo

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
- Add the keybindings to `~/.config/skhd/skhdrc`
- Start or restart skhd
- Default keybindings: `⌘4` and `⌘5`

### 2. Use It

**Tile first 4 windows (`⌘4`):**
Open at least 4 iTerm2 windows, then press `⌘4`:

```
┌─────────┬─────────┐
│ Window 1│ Window 2│
├─────────┼─────────┤
│ Window 3│ Window 4│
└─────────┴─────────┘
```

**Tile next 4 windows (`⌘5`):**
With 8 iTerm2 windows open, press `⌘5`:

```
┌─────────┬─────────┐
│ Window 5│ Window 6│
├─────────┼─────────┤
│ Window 7│ Window 8│
└─────────┴─────────┘
```

Windows are ordered by most-recently-focused, so the "first 4" are the 4 most recently used windows.

### 3. Disable (Optional)

To remove the keybinding:

```bash
./disable_keybinding.sh
```

## Configuration

### Change the Keybindings

Edit `config.sh` and set your preferred keybindings:

```bash
# Default: cmd + 4 and cmd + 5
KEYBINDING_1="cmd - 4"
KEYBINDING_2="cmd - 5"

# Alternative: cmd + shift + 4 and cmd + shift + 5
# KEYBINDING_1="cmd + shift - 4"
# KEYBINDING_2="cmd + shift - 5"
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
# Tile windows 1-4
./tile_iterm_quadrants.sh 0

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

### Keybindings not working

1. Check if skhd is running: `pgrep skhd`
2. Restart skhd manually: `killall skhd && skhd &`
3. Check logs: `tail -f /tmp/skhd.stderr`
4. Verify keybindings: `cat ~/.config/skhd/skhdrc`

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
