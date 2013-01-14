-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- Store the selected world and level
storyboard.worlds = 0
storyboard.level = 0

-- load menu screen
storyboard.gotoScene( "worlds" )