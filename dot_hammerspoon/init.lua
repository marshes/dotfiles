require("hs.ipc")

local spaces = require("hs.spaces")
local hotkey = require("hs.hotkey")
local screen = require("hs.screen")

-- Function to get indexed spaces for a screen
local function getIndexedSpaces(scr)
    local allSpaces = spaces.allSpaces()
    local screenSpaces = allSpaces[scr:getUUID()] or {}
    local indexedSpaces = {}
    for i, spaceID in ipairs(screenSpaces) do
        indexedSpaces[i] = spaceID
    end
    return indexedSpaces
end

-- Generic function that takes target number as parameter
local function ensureSpaces(targetCount)
    local mainScreen = screen.mainScreen()
    local indexedSpaces = getIndexedSpaces(mainScreen)
    local spaceCount = #indexedSpaces
    
    if spaceCount < targetCount then
        for i = 1, targetCount - spaceCount do
            spaces.addSpaceToScreen(mainScreen)
        end
        print("Added " .. (targetCount - spaceCount) .. " spaces to main screen")
    elseif spaceCount > targetCount then
        for i = spaceCount, targetCount + 1, -1 do
            spaces.removeSpace(indexedSpaces[i])
        end
        print("Removed " .. (spaceCount - targetCount) .. " spaces from main screen")
    else
        print("Main screen already has " .. targetCount .. " spaces")
    end
end

-- Two specific functions with different target counts
function ensureSpacesFive()
    ensureSpaces(5)
end

function ensureSpacesOne()
    ensureSpaces(1)
end