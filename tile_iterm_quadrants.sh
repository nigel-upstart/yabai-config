#!/usr/bin/env bash

# Tile the first 4 iTerm2 windows into a 2x2 quadrant layout
# Works with yabai in float mode using explicit grid placement

# Check if yabai is available
if ! command -v yabai &> /dev/null; then
    echo "Error: yabai is not installed or not in PATH"
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Install with: brew install jq"
    exit 1
fi

# Query all iTerm2 windows and get their IDs
# Filter for iTerm2 app, get the first 4 window IDs
window_ids=$(yabai -m query --windows | \
    jq -r '.[] | select(.app=="iTerm2") | .id' | \
    head -n 4)

# Check if we found any iTerm windows
if [ -z "$window_ids" ]; then
    echo "No iTerm2 windows found"
    exit 0
fi

# Count how many windows we found
window_count=$(echo "$window_ids" | wc -l | tr -d ' ')
echo "Found $window_count iTerm2 window(s)"

# Grid placement for 2x2 quadrants
# Format: rows:cols:start-x:start-y:width:height
POSITIONS=(
    "2:2:0:0:1:1"  # top-left
    "2:2:1:0:1:1"  # top-right
    "2:2:0:1:1:1"  # bottom-left
    "2:2:1:1:1:1"  # bottom-right
)

# Tile each window to its quadrant
count=0
while IFS= read -r window_id; do
    if [ $count -lt 4 ]; then
        position=${POSITIONS[$count]}
        echo "Placing window $window_id at position $position"
        yabai -m window "$window_id" --grid "$position"
        ((count++))
    fi
done <<< "$window_ids"

echo "Tiled $count iTerm2 window(s) into quadrants"
