-----------------------------------------------------------------------------------------
--
-- levels.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require "widget"

local scene = storyboard.newScene()

-- Table to hold level buttons
local levels = {}

-- 'onRelease' event listener for playBtn
local function buttonRelease(event)
	storyboard.level = event.target.id
	-- go to levels scene
	storyboard.gotoScene( "play", "fade", 500 )
	
	return true	-- indicates successful touch
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local background = display.newImageRect("background.png",480,320)
	background.x = 240; 	background.y = 160
	group:insert(background)

	-- create 20 buttons to choose the level	
	for i=0,3 do
		for j=1,5 do
			current = i*5 + j  -- This calculates the current position in the table
			levels[current] = widget.newButton{
				label=current,
				id=current,
				default = "button.png",
				width=64, height=64,
				onRelease = buttonRelease	-- event listener function
			}
			levels[current].x = 45 + (j*65)
			levels[current].y = 60+ (i*65)
			
			--   If you are using the last publicly available version of Corona, you may
			--   need to replace the following line with:
			--   group:insert( levels[current].view )
			group:insert( levels[current] )
			
		end
	end
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	for i=#levels,1,-1 do
		if levels[i] then
			levels[i]:removeSelf()	-- widgets must be manually removed
			levels[i] = nil
		end
	end
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene