#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop Aerospace
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

#check if hammerspoon is running, if not, open it
if [ "$(osascript -e 'tell application "System Events" to (name of processes) contains "Hammerspoon"')" = "false" ]; then
    open /Applications/Hammerspoon.app
fi

defaults write com.apple.dock "expose-group-apps" -bool "false" && killall Dock

brew services start skhd
killall Barik
killall AeroSpace

# Show menu bar (disable auto-hide)
osascript << EOF
tell application "System Events"
    set autohide menu bar of dock preferences to false
#    set the autohide of the dock preferences to false
end tell
EOF

sleep 1

/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs -c 'ensureSpacesFive()'

killall Hammerspoon
killall SwipeAeroSpace

echo "Aerospace stopped"
