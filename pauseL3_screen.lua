-----------------------------------------------------------------------------------------
-- pause_screen.lua
-- Created by: Sasha Malko
-- Date: May 14, 2018
-- Description: This is the pause page, displaying a play button to the game.
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "pause_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) 

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg
local cover
local unpauseButton
local pauseText
local playText

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to game
local function PlayTransition()
    composer.hideOverlay("crossFade", 400 ) 
    -- make character visible again
    character.isVisible = true
    lollipop1.isVisible = true
    lollipop2.isVisible = true
    lollipop3.isVisible = true
    lollipop4.isVisible = true
    
    --allowing the game to continue
    if (questionsAnswered > 0) then
        if (Obstacles ~= nil) and (Obstacles.isBodyActive == true) then
            physics.addBody(Obstacles)
            Obstacles.isVisible = true
            ResumeGame() 
end end end
 

-- Creating Transitioning Function back main menu
local function MainMenuTransition() 
  composer.gotoScene( "main_menu" )
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

    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.8)

    --Insert the bkg to the scene group 
    sceneGroup:insert( bkg )

    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.9, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(220/255, 195/255, 32/255)

    --Insert the cover to the scene group 
    sceneGroup:insert( cover )

    -- create the pause text object
    pauseText = display.newText("Paused", display.contentCenterX, display.contentCenterY*3/8, Arial, 60)
    pauseText:setTextColor(0,0,0)

    --Insert the pause text to the scene group 
    sceneGroup:insert( pauseText )

    -- create the play text object
    playText = display.newText("Continue playing?", display.contentCenterX, display.contentCenterY*8/8, Arial, 60)
    playText:setTextColor(0,0,0)

    --Insert the play text to the scene group
    sceneGroup:insert( playText )

    ------------------------------------------------------------------------------------------
    --WIDGETS
    ------------------------------------------------------------------------------------------

    -- Creating unpause Button
    unpauseButton = widget.newButton( 
    {
        -- Setting Position
        x = 200,
        y = 390,

        -- Setting Dimensions
        width = 100,
        height = 100,

        -- Setting Visual Properties
        defaultFile = "Images/UnpauseButtonUnpressed.png",
        overFile = "Images/UnpauseButtonPressed.png",

        -- Setting Functional Properties
        onRelease = PlayTransition

    } )
    
-----------------------------------------------------------------------------------------
    -- Associating Buttons with this scene
    sceneGroup:insert( unpauseButton )

    -- Creating main menu Button
    MainMenuButton = widget.newButton( 
    {
        -- Setting Position
        x = 800,
        y = 600,

        -- Setting Dimensions
        width = 200,
        height = 100,

        -- Setting Visual Properties
        defaultFile = "Images/MainMenuButtonUnpressed.png",
        overFile = "Images/MainMenuButtonPressed.png",

        -- Setting Functional Properties
        onRelease = MainMenuTransition

    } )
    
-----------------------------------------------------------------------------------------
    -- Associating Buttons with this scene
    sceneGroup:insert( MainMenuButton )

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
        
    -----------------------------------------------------------------------------------------
 
    -- Called when the scene is now on screen.
    elseif ( phase == "did" ) then
        
        --pause the audio
        audio.pause()

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

    -- Called when the scene is on screen (but is about to go off screen).
    if ( phase == "will" ) then
        
    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        --Resume the audio
        audio.resume()
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

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