#!/bin/bash

# Usage: script.sh [next|prev]
# Default is next if no argument provided
DIRECTION=${1:-next}

# Get current workspace
CURRENT=$(aerospace list-workspaces --monitor focused --visible)

# Get all workspaces into array
ALL_WORKSPACES=($(aerospace list-workspaces --monitor focused))

# Get empty workspaces into array
EMPTY_WORKSPACES=($(aerospace list-workspaces --monitor focused --empty))

# Filter out empty workspaces to create non-empty array
NON_EMPTY=()
for workspace in "${ALL_WORKSPACES[@]}"; do
    is_empty=false
    for empty in "${EMPTY_WORKSPACES[@]}"; do
        if [[ "$workspace" == "$empty" ]]; then
            is_empty=true
            break
        fi
    done
    if [[ "$is_empty" == false ]]; then
        NON_EMPTY+=("$workspace")
    fi
done

# Find current workspace index in non-empty array
CURRENT_INDEX=-1
for i in "${!NON_EMPTY[@]}"; do
    if [[ "${NON_EMPTY[$i]}" == "$CURRENT" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# Safety check
if [[ $CURRENT_INDEX -eq -1 ]]; then
    echo "Error: Current workspace not found in non-empty workspaces"
    exit 1
fi

# Calculate target index with wrapping
ARRAY_LENGTH=${#NON_EMPTY[@]}

if [[ "$DIRECTION" == "next" ]]; then
    TARGET_INDEX=$(( (CURRENT_INDEX + 1) % ARRAY_LENGTH ))
else
    TARGET_INDEX=$(( (CURRENT_INDEX - 1 + ARRAY_LENGTH) % ARRAY_LENGTH ))
fi

# Switch to target workspace
TARGET_WORKSPACE="${NON_EMPTY[$TARGET_INDEX]}"
aerospace workspace "$TARGET_WORKSPACE"