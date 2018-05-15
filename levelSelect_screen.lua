-----------------------------------------------------------------------------------------
-- levelSelect_screen.lua
-- Created by: Sasha Malko
-- Date: May 14, 2018
-- Description: This is the levelSelect page, displaying a back button to the main menu.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "levelSelect_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) 

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local backButton
local level1Button
local level2Button
local level3Button
local levelText

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "slideLeft", time = 500})
end

-- Creating Transitioning Function back to main menu
local function Level1Transition( )
    composer.gotoScene( "level1_screen", {effect = "zoomInOut", time = 500})
end

-- Creating Transitioning Function back to main menu
local function Level2Transition( )
    composer.gotoScene( "level2_screen", {effect = "zoomInOut", time = 500})
end

-- Creating Transitioning Function back to main menu
local function Level3Transition( )
    composer.gotoScene( "level3_screen", {effect = "zoomInOut", time = 500})
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

    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    level1Button = widget.newButton( 
    {
        -- Setting Position
        x = 150,
        y = 250,

        -- Setting Dimensions
        width = 200,
        height = 200,

        -- Setting Visual Properties
        defaultFile = "Images/Level1ButtonUnpressed.png",
        overFile = "Images/Level1ButtonUnpressed.png",

        -- Setting Functional Properties
        onRelease = Level1Transition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( level1Button )

    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    level2Button = widget.newButton( 
    {
        -- Setting Position
        x = 500,
        y = 250,

        -- Setting Dimensions
        width = 200,
        height = 200,

        -- Setting Visual Properties
        defaultFile = "Images/Level2ButtonUnpressed.png",
        overFile = "Images/Level2ButtonUnpressed.png",

        -- Setting Functional Properties
        onRelease = Level2Transition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( level2Button )

    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    level3Button = widget.newButton( 
    {
        -- Setting Position
        x = 850,
        y = 250,

        -- Setting Dimensions
        width = 200,
        height = 200,

        -- Setting Visual Properties
        defaultFile = "Images/Level3ButtonUnpressed@2x.png",
        overFile = "Images/Level3ButtonUnpressed@2x.png",

        -- Setting Functional Properties
        onRelease = Level3Transition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( level3Button )

    --Inserting the Music On/Off text, it's position and colour
    levelText = display.newText( "Level Select" , 0, 0, nil, 80)
    levelText.x = 500
    levelText.y = 60
    levelText:setTextColor(0,0,0)

    -- Associating Buttons with this scene
    sceneGroup:insert( levelText )
    
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