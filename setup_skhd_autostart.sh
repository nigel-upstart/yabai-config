#!/usr/bin/env bash

# Set up skhd to start automatically at login using LaunchAgent

PLIST_PATH="$HOME/Library/LaunchAgents/com.koekeishiya.skhd.plist"
SKHD_BIN="$(which skhd)"

echo "Setting up skhd to start at login..."

# Create LaunchAgents directory if it doesn't exist
mkdir -p "$HOME/Library/LaunchAgents"

# Create the plist file
cat > "$PLIST_PATH" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.koekeishiya.skhd</string>
    <key>ProgramArguments</key>
    <array>
        <string>${SKHD_BIN}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/skhd.stdout</string>
    <key>StandardErrorPath</key>
    <string>/tmp/skhd.stderr</string>
</dict>
</plist>
EOF

echo "✓ Created LaunchAgent plist at $PLIST_PATH"

# Load the plist
launchctl load -w "$PLIST_PATH" 2>/dev/null || echo "Note: plist may already be loaded"

echo "✓ skhd is now set to start automatically at login"
echo ""
echo "To verify skhd is running: pgrep -x skhd"
echo "To check logs: tail -f /tmp/skhd.stderr"
