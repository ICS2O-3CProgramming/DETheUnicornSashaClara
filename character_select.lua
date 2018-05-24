-----------------------------------------------------------------------------------------
-- credits_screen.lua
-- Created by: Sasha Malko
-- Date: May 10, 2018
-- Description: This is the credits page, displaying a back button to the main menu.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "credits_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) 

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local backButton

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
function CharacterTransition( )
    composer.gotoScene( "level1_screen", {effect = "slideLeft", time = 1000})
end

function BlueTransition()
    composer.gotoScene( "level1_blue", {effect = "slideLeft", time = 1000})
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
    bkg_image = display.newImageRect("Images/BlueBackground.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    --Inserting the settings text, it's position and colour
    selectText = display.newText( "Select your character" , 0, 0, nil, 80)
    selectText.x = 500
    selectText.y = 60
    selectText:setTextColor(0,0,0)

    -- Associating display objects with this scene 
    sceneGroup:insert( selectText )

    --Inserting the settings text, it's position and colour
    blueText = display.newText( "Blue Unicorn" , 0, 0, nil, 50)
    blueText.x = 800
    blueText.y = 450
    blueText:setTextColor(0,0,0)

    -- Associating display objects with this scene 
    sceneGroup:insert( blueText )

    --Inserting the settings text, it's position and colour
    pinkText = display.newText( "Pink Unicorn" , 0, 0, nil, 50)
    pinkText.x = 200
    pinkText.y = 450
    pinkText:setTextColor(0,0,0)

    -- Associating display objects with this scene 
    sceneGroup:insert( pinkText )
    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = 200,
        y = 350,

        -- Setting Dimensions
         width = 200,
         height = 100,

        -- Setting Visual Properties
        defaultFile = "Images/RectangularUnicorn.png",
        overFile = "Images/RectangularUnicorn.png",

        -- Setting Functional Properties
        onRelease = CharacterTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )

        -- Creating Back Button
    blueButton = widget.newButton( 
    {
        -- Setting Position
        x = 800,
        y = 350,

        -- Setting Dimensions
         width = 200,
         height = 100,

        -- Setting Visual Properties
        defaultFile = "Images/PinkBackground.png",
        overFile = "Images/PinkBackground.png",

        -- Setting Functional Properties
        onRelease = BlueTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( blueButton )

    
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