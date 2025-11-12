#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Aerospace Top Window Gaps
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Window toggle


FILE=~/.config/aerospace/aerospace.toml
perl -i -pe 's/(outer\.top.*}, )(\d+)]/$1 . ($2 == 22 ? 10 : 22) . "]"/e' "$FILE"
aerospace reload-config --no-gui
echo "Toggling top window gap"
