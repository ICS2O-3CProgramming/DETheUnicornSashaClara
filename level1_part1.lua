-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Sasha Malko
-- Date: May 14, 2018
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_part1"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image
local rainbow1
local rainbow2
local clouds
local rArrow 
local uArrow
local lArrow
local motionx = 0
local SPEED = 8
local GO = -8
local LINEAR_VELOCITY = -100
local GRAVITY = 7
local leftW 
local rightW
local topW
local floor
local door
local Obstacles
local pauseButton

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
questionsAnswered = 0

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 

 -- Creating Transitioning Function back to main menu
local function PauseTransition( )
    -- show overlay with pause screen
    composer.showOverlay( "pause_screen", { isModal = true, effect = "fade", time = 100}) 
    --make the character invisible 
    character.isVisible = false
end

-- When right arrow is touched, move character right
local function right (touch)
    motionx = SPEED
    character.xScale = 1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (character ~= nil) then
        character:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end

-- When right arrow is touched, move character right
local function left (touch)
    motionx = GO
    character.xScale = -1
end

-- Move character horizontally
local function movePlayer (event)
    character.x = character.x + motionx
end
 
-- Stop character movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end

--Creating function to transition to you lose screen
local function YouLoseTransition()
    composer.gotoScene( "you_lose" )
end

--Adding the touch listeners for the arrows
local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

--Removing the touch listeners for the arrows
local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

--Adding runtime listerners to move and stop
local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop )
end

--Removing runtime listerners to move and stop
local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop )
end

--Creating a function to replace the character 
local function ReplaceCharacter()

    --Checking what character the user chose and placing it on the screen
    if (characterChoice == "pinkUnicorn") then
        character = display.newImageRect("Images/RectangularUnicorn.png", 100, 150)
    else
        character = display.newImageRect("Images/PinkBackground.png", 100, 150)
    end
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 130
    character.height = 80
    character.myName = "Unicorn"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0.5, friction=0.5, bounce=0.5, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

--Creating a function to make the hearts visible
local function MakeHeartsVisible()
    heart1.isVisible = true
    heart2.isVisible = true
    heart3.isVisible = true
end

local function onCollision( self, event )

    if ( event.phase == "began" ) then


        if  (event.target.myName == "clouds") then

            -- get the obstacle that the user hit
            Obstacles = event.target

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1

            -- show overlay with the question
            composer.showOverlay( "level1Clouds_questions", { isModal = true, effect = "fade", time = 100})
        end

        if  (event.target.myName == "door") then
            
            -- get the obstacle that the user hit
            Obstacles = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1

            -- show overlay with the question
            composer.showOverlay( "level1_part1Questions", { isModal = true, effect = "fade", time = 100})

        end        
    end
end

local function AddCollisionListeners()
    -- if character collides with clouds, onCollision will be called
    clouds.collision = onCollision
    clouds:addEventListener( "collision" )

    -- if character collides with door, onCollision will be called    
    door.collision = onCollision
    door:addEventListener( "collision" )

end

--Creating function to remove the collison listeners 
local function RemoveCollisionListeners()
    clouds:removeEventListener( "collision" )
    door:removeEventListener( "collision" )

end

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( rainbow1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( rainbow2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody(door, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody( clouds, "static", { density=1.0, friction=0.3, bounce=0.2 } )  
    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )


end

local function RemovePhysicsBodies()
    --Remove from the physics engine
    physics.removeBody(rainbow1)
    physics.removeBody(rainbow2)
    physics.removeBody(door)
    physics.removeBody(clouds)
    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

--Function to replace the character
function ResumeGame()
  ReplaceCharacter()
end

--Function to add the arrow event listeners and runtime listeners
function Add()
    AddArrowEventListeners()
    AddRuntimeListeners()
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
    bkg_image = display.newImageRect("Images/BlueBackground.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

     -- Insert background image into the scene group 
    sceneGroup:insert( bkg_image )    
    
    -- Insert the rainbow
    rainbow1 = display.newImageRect("Images/Rainbow.png", 0, 0)
    rainbow1.x = 100
    rainbow1.y = 480
    rainbow1.width = 400
    rainbow1.height = 130
        
    -- Insert rainbow into the scene group 
    sceneGroup:insert( rainbow1 )

    -- Insert the rainbow
    rainbow2 = display.newImageRect("Images/Rainbow.png", 0, 0)
    rainbow2.x = 850
    rainbow2.y = 480
    rainbow2.width = 500
    rainbow2.height = 130
        
    -- Insert rainbow into the scene group 
    sceneGroup:insert( rainbow2 )

    -- Insert clouds 
    clouds = display.newImageRect("Images/Clouds.png", 0, 0)
    clouds.x = 500
    clouds.y = 700
    clouds.myName = "clouds"
    clouds.width = 1100
    clouds.height = 300
        
    -- Insert clouds into the scene group  
    sceneGroup:insert( clouds )

    -- Insert the Door
    door = display.newImage("Images/Door.png", 0, 0)
    door.x = 900
    door.y = 340
    door.myName = "door"
    door.width = 30
    door.height = 150

    -- Insert the door into the scene group
    sceneGroup:insert( door )

    -- Insert the heart
    heart1 = display.newImageRect("Images/heart.png", 80, 80)
    heart1.x = 50
    heart1.y = 50
    heart1.isVisible = true

    -- Insert the heart into the scene group
    sceneGroup:insert( heart1 )

    -- Insert the heart
    heart2 = display.newImageRect("Images/heart.png", 80, 80)
    heart2.x = 130
    heart2.y = 50
    heart2.isVisible = true

    -- Insert the heart into the scene group
    sceneGroup:insert( heart2 )

     -- Insert the heart
    heart3 = display.newImageRect("Images/heart.png", 80, 80)
    heart3.x = 210
    heart3.y = 50
    heart3.isVisible = true

    -- Insert the heart into the scene group
    sceneGroup:insert( heart3 )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/ArrowButtonUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
    rArrow.rotation = 180
   
    -- Insert the rArrow into the scene group
    sceneGroup:insert( rArrow )

    --Insert the up arrow
    uArrow = display.newImageRect("Images/ArrowButtonUnpressed.png", 100, 50)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10
    uArrow.rotation = 90

    -- Insert the lArrow into the scene group
    sceneGroup:insert( uArrow )

    --Insert the left arrow
    lArrow = display.newImageRect("Images/ArrowButtonUnpressed.png", 100, 50)
    lArrow.x = 750
    lArrow.y = 730

    -- Insert the lArrow into the scene group
    sceneGroup:insert(lArrow)

    --Insert the left wall
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- Insert the leftW into the scene group
    sceneGroup:insert( leftW )

    --Insert the right wall
    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert the rightW into the scene group
    sceneGroup:insert( rightW )

    --Insert the top wall
    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert the topW into the scene group
    sceneGroup:insert( topW )

    -- Insert the floor
    floor = display.newImageRect("Images/PinkBackground.png", 1024, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 1.06

    -- Insert the floor into the scene group
    sceneGroup:insert( floor )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Pause Button
    pauseButton = widget.newButton( 
    {
        -- Setting Position
        x = 900,
        y = 80,

        -- Setting Dimensions
         width = 80,
         height = 80,

        -- Setting Visual Properties
        defaultFile = "Images/PauseButtonUnpressed.png",
        overFile = "Images/PauseButtonPressed.png",

        -- Setting Functional Properties
        onRelease = PauseTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( pauseButton )


end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
        --Start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY )

    elseif ( phase == "did" ) then

        --Number of questions answered to 0
        questionsAnswered = 0

        -- make all lives visible
        MakeHeartsVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the character, add physics bodies and runtime listeners
        ReplaceCharacter()
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    if ( phase == "will" ) then

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        --Remove physics, collision, arrow, and runtime listeners. Make character invisible
        RemoveCollisionListeners()
        RemovePhysicsBodies()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

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