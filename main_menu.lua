-----------------------------------------------------------------------------------------
-- main_menu.lua
-- Created by: Sasha Malko
-- Date: May 10, 2018
-- Description: This is the main menu, displaying the credits, instructions, settings & play button
-----------------------------------------------------------------------------------------

--hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--load physics
local physics = require("physics")

--start physics for the whole game
physics.start()

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local playButton
local creditsButton
local instructionsButton
local settingsButton
local ground 

--Sounds
local easy = audio.loadStream("Sounds/easy.mp3")
local easyChannel = audio.play(easy, {channel = 2, loops = -1})

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "flip", time = 500})
end 
----------------------------------------------------------------------------------------
-- Creating Transition to Level1 Screen
local function LevelSelectScreenTransition( )
    composer.gotoScene( "levelSelect_screen", {effect = "slideLeft", time = 1000})
end    
----------------------------------------------------------------------------------------
-- Creating Transition Function to Instructions Page
local function InstructionsTransition( )       
    composer.gotoScene( "instructions_screen", {effect = "slideDown", time = 500})
end 
----------------------------------------------------------------------------------------
-- Creating Transition Function to Settings Page
local function SettingsTransition( ) 
   composer.gotoScene( "settings_screen", {effect = "slideDown", time = 500}) 
end 

local function AddPhysicsBodies()
        --Add the ground to physics
    physics.addBody(ground, "static", {friction=0.5, bounce=0.3})

    --add the background image to physics
    physics.addBody(bkg_image, {density=1.0, friction=0.5, bounce=0.3})
end 

local function RemovePhysicsBodies()
        --Add the ground to physics
    physics.removeBody(ground, "static", {friction=0.5, bounce=0.3})

    --add the background image to physics
    physics.removeBody(bkg_image, {density=1.0, friction=0.5, bounce=0.3})
end 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------
    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/main_menu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = 0
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    --Setting the colour of the background 
    display.setDefault("background", 142/255, 223/255, 250/255)

    --Create the ground
    ground = display.newImage("Images/BlueBackground.png", 0, 0)

    --Set the x and y pos for the ground 
    ground.x = display.contentCenterX
    ground.y = 847

    --Change the width of the ground to be the same as the screen
    ground.width = display.contentWidth


    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 500,
            y = 650,

            width = 200,
            height = 100,

            -- Inserting the images 
            defaultFile = "Images/PlayButtonUnpressed.png",
            overFile = "Images/PlayButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = LevelSelectScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 880,
            y = 60,

            width = 200,
            height = 100,

            -- Inserting the images 
            defaultFile = "Images/CreditsButtonUnpressed.png",
            overFile = "Images/CreditsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    -----------------------------------------------------------------------------------------   
    
     -- Creating instructions Button
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 120,
            y = 60,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the Instructions transition function
            onRelease = InstructionsTransition
        } ) 
    
    -----------------------------------------------------------------------------------------

         -- Creating settings Button
    settingsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 500,
            y = 60,

            width = 200,
            height = 100,

            -- Inserting the images 
            defaultFile = "Images/SettingsButtonUnpressed.png",
            overFile = "Images/SettingsButtonPressed.png",

            -- When the button is released, call the Settings transition function
            onRelease = SettingsTransition
        } ) 

-----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( ground )
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( settingsButton )

end -- function scene:create( event )   


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
        AddPhysicsBodies()
        
    

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
         RemovePhysicsBodies()
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    -- Called prior to the removal of scene's view ("sceneGroup").

end -- function scene:destroy( event )

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