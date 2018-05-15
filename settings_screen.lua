-----------------------------------------------------------------------------------------
-- settings_screen.lua
-- Created by: Sasha Malko
-- Date: May 10, 2018
-- Description: This is the settings page, displaying a back button and a mute/unmute button.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "settings_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local backButton
local unmuteButton
local muteButton
local musicText
local settingsText

--Sounds
local easy = audio.loadSound("Sounds/easy.mp3")
local easyChannel 

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "slideRight", time = 500})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------
    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImageRect("Images/PinkBackground.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    --Inserting the unmute button and setting it's position, dimensions and visibility 
    unmuteButton = display.newImageRect("Images/MusicButtonUnpressed.png", 500, 500)
    unmuteButton.x = 150
    unmuteButton.y = 290
    unmuteButton.width = 200
    unmuteButton.height = 100
    unmuteButton.isVisible = true

    --Inserting the mute button and setting it's position, dimensions and visibility 
    muteButton = display.newImageRect("Images/MusicButtonPressed.png", 500, 500)
    muteButton.x = 150
    muteButton.y = 290
    muteButton.width = 200
    muteButton.height = 100
    muteButton.isVisible = false

    --Inserting the settings text, it's position and colour
    settingsText = display.newText( "Settings" , 0, 0, nil, 80)
    settingsText.x = 500
    settingsText.y = 60
    settingsText:setTextColor(0,0,0)

    --Inserting the Music On/Off text, it's position and colour
    musicText = display.newText( "Music On/Off" , 0, 0, nil, 50)
    musicText.x = 450
    musicText.y = 290
    musicText:setTextColor(0,0,0)

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( unmuteButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( settingsText )
    sceneGroup:insert( musicText )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = 900,
        y = 500,

        -- Setting Dimensions
         width = 200,
         height = 100,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressed.png",
        overFile = "Images/BackButtonPressed.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )


    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.

        -- Function: unmuteButtonListener
        -- Input: touch listener
        -- Output: none
        -- Description: When the mute button is clicked, the music will turn off and when the 
        -- unmute button is clicked, the music will turn on again. 
        local function unmuteButtonListener(touch)
            if (touch.phase == "began") then
                unmuteButton.isVisible = true
                muteButton.isVisible = false
                easyChannel = audio.play(easy, {channel = 3, loops = -1})
            end
        
            if (touch.phase == 'ended') then 
                unmuteButton.isVisible = false
                muteButton.isVisible = true
                audio.stop()
            end
        end


       --add the respective listeners to each object
       unmuteButton:addEventListener("touch", unmuteButtonListener)

        -- Function: muteButtonListener
        -- Input: touch listener
        -- Output: none
        -- Description: When the mute button is clicked, the music will turn off and when the 
        -- unmute button is clicked, the music will turn on again.
        local function muteButtonListener(touch)
            if (touch.phase == "began") then
                unmuteButton.isVisible = false
                muteButton.isVisible = true
                audio.stop()
            end
       
            if (touch.phase == 'ended') then 
                unmuteButton.isVisible = true
                muteButton.isVisible = false
                easyChannel = audio.play(easy, {channel = 3, loops = -1})  
            end
        end

        
        --add the respective listeners to each object
        muteButton:addEventListener("touch", muteButtonListener)
    end
end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup").


end --function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene