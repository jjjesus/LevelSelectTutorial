-----------------------------------------------------------------------------------------
--
-- worlds.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require "widget"

local buttonGroup = display.newGroup()
local scene = storyboard.newScene()
local worldPage = 0
local maxWorlds = 6
local movingScreen = false

-- Table to hold world buttons
local worlds = {}

local function backgroundTouch(event)
	if (event.phase=="ended") then
		movingScreen=false	
	end
	if (event.phase=="moved" and movingScreen==false) then
		local delta = event.xStart - event.x

		if (delta < -10 and worldPage>0) then
			movingScreen=true
			worldPage = worldPage -1
			buttonGroup:translate(320, 0)
		end
		if (delta > 10 and worldPage<maxWorlds/2) then
			movingScreen=true
			worldPage = worldPage + 1
			buttonGroup:translate(-320, 0)
		end
	end
	return true
end	

-- 'onRelease' event listener for buttons
local function buttontouch(event)
	if (event.phase=="release") then
		movingScreen=false	
		storyboard.world = event.target.id  -- Save the selected world
		storyboard.gotoScene( "levels", "fade", 500 )  	-- go to levels scene
	end
	return true	-- indicates successful touch
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	local background = display.newImageRect("background.png",480,320)
	background.x = 240; 	background.y = 160
	background:addEventListener("touch",backgroundTouch)
	group:insert(background)
	group:insert(buttonGroup)
	-- create three widget buttons to select the game world	
	for i=1,maxWorlds do
		worlds[i] = widget.newButton{
			label="World "..i,
			default = "button.png",
			id=i,
			width=128, height=128,
			onEvent = buttontouch	-- event listener function
		}
		worlds[i].x = (i*160) + (i % 2)*20
		worlds[i].y = display.contentHeight * 0.5

		--   If you are using the last publicly available version of Corona, you may
		--   need to replace the following line with:
		--   group:insert( worlds[i].view )			
		
		buttonGroup:insert( worlds[i] )
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
	
	for i=#worlds, 1, -1 do
		if worlds[i] then
			worlds[i]:removeSelf()	-- widgets must be manually removed
			worlds[i] = nil
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