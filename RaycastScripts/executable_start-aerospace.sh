#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Aerospace
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

#check if hammerspoon is running, if not, open it
if [ "$(osascript -e 'tell application "System Events" to (name of processes) contains "Hammerspoon"')" = "false" ]; then
    open /Applications/Hammerspoon.app
    sleep 1
fi

#check if aeroswipe is running, if not, open it
if [ "$(osascript -e 'tell application "System Events" to (name of processes) contains "SwipeAeroSpace"')" = "false" ]; then
    open /Applications/SwipeAeroSpace.app
    sleep 1
fi

# Show menu bar (enable auto-hide)
osascript << EOF
tell application "System Events"
    set autohide menu bar of dock preferences to true
end tell
EOF

defaults write com.apple.dock "expose-group-apps" -bool "true" && killall Dock

brew services stop skhd

#use hammerspoon to only have 1 space
/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs -c 'ensureSpacesOne()'

open /Applications/Barik.app
open /Applications/AeroSpace.app

# Show menu bar (disable auto-hide)
osascript << EOF
tell application "System Events"
    set autohide menu bar of dock preferences to true
    set the autohide of the dock preferences to true
end tell
EOF

echo "Aerospace started"
