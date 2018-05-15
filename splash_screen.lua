-----------------------------------------------------------------------------------------
--splash_screen.lua
--Created by: Sasha Malko
--Date: May 4, 2018
--Description: This is the splash screen of the game. It displays the 
--company logo and the objects in the logo move across the screen.
-----------------------------------------------------------------------------------------

--Use Composer Library
local composer = require( "composer" )

--Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

--Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
--LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
--The local variables for this scene
local roseOne 
local roseTwo
local roseThree
local roseFour
local roseFive 
local roseSix
local roseSeven
local roseEight
local roseNine
local roseTen
local roseEleven
local roseTwelve
local rosella
local backgroundColour
local backgroundColour2
local scrollXSpeed = 8
local loadingText


--Sounds
local horseSound = audio.loadSound("Sounds/Horse.mp3")
local horseSoundChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------


--The function that moves the objects in the logo across the screen
local function moveRosella()
    
    --move the rose to the right
    roseOne.x = roseOne.x + scrollXSpeed
    --make the rose spin
    roseOne.rotation = roseOne.rotation + 5 
    --make the rose fade out 
    roseOne.alpha = roseOne.alpha - 0.01

    --move the rose to the right
    roseTwo.x = roseTwo.x + scrollXSpeed
    --make the rose spin
    roseTwo.rotation = roseTwo.rotation + 5
    --make the rose fade out 
    roseTwo.alpha = roseTwo.alpha - 0.01

    --move the rose to the right
    roseThree.x = roseThree.x + scrollXSpeed
    --make the rose spin
    roseThree.rotation = roseThree.rotation + 5
    --make the rose fade out 
    roseThree.alpha = roseThree.alpha - 0.01

    --move the rose to the right
    roseFour.x = roseFour.x + scrollXSpeed
    --make the rose spin
    roseFour.rotation = roseFour.rotation + 5
    --make the rose fade out 
    roseFour.alpha = roseFour.alpha - 0.01

    --move the rose to the right
    roseFive.x = roseFive.x + scrollXSpeed
    --make the rose spin
    roseFive.rotation = roseFive.rotation + 5
    --make the rose fade out 
    roseFive.alpha = roseFive.alpha - 0.01

    --move the rose to the right
    roseSix.x = roseSix.x + scrollXSpeed
    --make the rose spin
    roseSix.rotation = roseSix.rotation + 5
    --make the rose fade out 
    roseSix.alpha = roseSix.alpha - 0.01

    --move the rose to the right
    roseSeven.x = roseSeven.x + scrollXSpeed
    --make the rose spin
    roseSeven.rotation = roseSeven.rotation + 5
    --make the rose fade out 
    roseSeven.alpha = roseSeven.alpha - 0.01

    --move the rose to the right
    roseEight.x = roseEight.x + scrollXSpeed
    --make the rose spin
    roseEight.rotation = roseEight.rotation + 5
    --make the rose fade out 
    roseEight.alpha = roseEight.alpha - 0.01

    --move the rose to the right
    roseNine.x = roseNine.x + scrollXSpeed
    --make the rose spin
    roseNine.rotation = roseNine.rotation + 5
    --make the rose fade out 
    roseNine.alpha = roseNine.alpha - 0.01

    --move the rose to the right
    roseTen.x = roseTen.x + scrollXSpeed
    --make the rose spin
    roseTen.rotation = roseTen.rotation + 5
    --make the rose fade out 
    roseTen.alpha = roseTen.alpha - 0.01

    --move the rose to the right
    roseEleven.x = roseEleven.x + scrollXSpeed
    --make the rose spin
    roseEleven.rotation = roseEleven.rotation + 5
    --make the rose fade out 
    roseEleven.alpha = roseEleven.alpha - 0.01

    --move the rose to the right
    roseTwelve.x = roseTwelve.x + scrollXSpeed
    --make the rose spin
    roseTwelve.rotation = roseTwelve.rotation + 5
    --make the rose fade out 
    roseTwelve.alpha = roseTwelve.alpha - 0.01

    --move the rosella to the right
    rosella.x = rosella.x + scrollXSpeed
    --make the rosella fade out 
    rosella.alpha = rosella.alpha - 0.01

    --make the rainbow halo spin
    backgroundColour.rotation = backgroundColour.rotation + 5

    --make the sunlight beam spin
    backgroundColour2.rotation = backgroundColour2.rotation + 5

    --make the text, rainbow halo, and sunlight beam disappear when the roses get to the edge of the screen
    if (roseOne.x > 1024) then
        backgroundColour.isVisible = false
        loadingText.isVisible = false
        backgroundColour2.isVisible = false
   end
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background colour
    display.setDefault("background", 163/255, 205/255, 241/255)

    -- Insert the rose image
    roseOne = display.newImageRect("Images/RoseOne.png", 200, 150)
    --make the rose have a swirl effect
    roseOne.fill.effect = "filter.swirl"
    roseOne.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseOne.x = 150
    roseOne.y = 200

    -- Insert the rose image
    roseTwo = display.newImageRect("Images/RoseTwo.png", 150, 100)
    --make the rose have a swirl effect
    roseTwo.fill.effect = "filter.swirl"
    roseTwo.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseTwo.x = 400
    roseTwo.y = 250

    -- Insert the rose image
    roseThree = display.newImageRect("Images/RoseThree.png", 150, 110)
    --make the rose have a swirl effect
    roseThree.fill.effect = "filter.swirl"
    roseThree.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseThree.x = 560
    roseThree.y = 160

    -- Insert the rose image
    roseFour = display.newImageRect("Images/RoseFour.png", 150, 110)
    --make the rose have a swirl effect
    roseFour.fill.effect = "filter.swirl"
    roseFour.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseFour.x = 850
    roseFour.y = 120

    -- Insert the rose image
    roseFive = display.newImageRect("Images/RoseFive.png", 150, 110)
    --make the rose have a swirl effect
    roseFive.fill.effect = "filter.swirl"
    roseFive.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseFive.x = 700
    roseFive.y = 350

    -- Insert the rose image
    roseSix = display.newImageRect("Images/RoseSix.png", 200, 150)
    --make the rose have a swirl effect
    roseSix.fill.effect = "filter.swirl"
    roseSix.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseSix.x = 900
    roseSix.y = 350

    -- Insert the rose image
    roseSeven = display.newImageRect("Images/RoseSeven.png", 150, 110)
    --make the rose have a swirl effect
    roseSeven.fill.effect = "filter.swirl"
    roseSeven.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseSeven.x = 900
    roseSeven.y = 550
   
    -- Insert the rose image
    roseEight = display.newImageRect("Images/RoseEight.png", 150, 110)
    --make the rose have a swirl effect
    roseEight.fill.effect = "filter.swirl"
    roseEight.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseEight.x = 860
    roseEight.y = 690

    -- Insert the rose image
    roseNine = display.newImageRect("Images/RoseNine.png", 100, 150)
    --make the rose have a swirl effect
    roseNine.fill.effect = "filter.swirl"
    roseNine.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseNine.x = 600
    roseNine.y = 640
   
    -- Insert the rose image
    roseTen = display.newImageRect("Images/RoseTen.png", 150, 110)
    --make the rose have a swirl effect
    roseTen.fill.effect = "filter.swirl"
    roseTen.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseTen.x = 400
    roseTen.y = 650

    -- Insert the rose image
    roseEleven = display.newImageRect("Images/RoseEleven.png", 150, 110)
    --make the rose have a swirl effect
    roseEleven.fill.effect = "filter.swirl"
    roseEleven.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseEleven.x = 150
    roseEleven.y = 650

    -- Insert the rose image
    roseTwelve = display.newImageRect("Images/RoseTwelve.png", 150, 110)
    --make the rose have a swirl effect
    roseTwelve.fill.effect = "filter.swirl"
    roseTwelve.fill.effect.intensity = 0.1

    -- set the initial x and y position of the rose
    roseTwelve.x = 200
    roseTwelve.y = 500

    -- Insert the rosella image
    rosella = display.newImageRect("Images/Rosella.png", 400, 150)
    --make the rosella name have a colour offset effect
    rosella.fill.effect = "filter.colorChannelOffset"
    rosella.fill.effect.xTexels = 16
    rosella.fill.effect.yTexels = 16

    -- set the initial x and y position of the rosella text
    rosella.x = 450
    rosella.y = 400

    -- Insert the background colour image
    backgroundColour = display.newImageRect("Images/BackgroundColour.png", 100, 100)

    -- set the initial x and y position of the background colour image
    backgroundColour.x = 450
    backgroundColour.y = 550

    --make the background colour have a rainbow halo effect
    backgroundColour.fill.effect = "generator.lenticularHalo"
    backgroundColour.fill.effect.posX = 0.5
    backgroundColour.fill.effect.posY = 0.5
    backgroundColour.fill.effect.aspectRatio = ( backgroundColour.width / backgroundColour.height )
    backgroundColour.fill.effect.seed = 1

    --Insert a second background colour image
    backgroundColour2 = display.newImageRect("Images/BackgroundColour.png", 100, 100)

    -- set the initial x and y position of the second background colour image
    backgroundColour2.x = 450
    backgroundColour2.y = 550

    --make the background colour have a beam of sunlight
    backgroundColour2.fill.effect = "generator.sunbeams"
    backgroundColour2.fill.effect.posX = 0.5
    backgroundColour2.fill.effect.posY = 0.5
    backgroundColour2.fill.effect.aspectRatio = ( backgroundColour2.width / backgroundColour2.height )
    backgroundColour2.fill.effect.seed = 0

    --create loading text 
    loadingText = display.newText("Loading...", 460, 630, nil, 30)
    --set the colour of the loadng text
    loadingText:setFillColor(91/255, 41/255, 119/255)

    -- insert all the images for the splash screen into its scene group
    sceneGroup:insert( roseOne )
    sceneGroup:insert( roseTwo )
    sceneGroup:insert( roseThree )
    sceneGroup:insert( roseFour )
    sceneGroup:insert( roseFive )
    sceneGroup:insert( roseSix )
    sceneGroup:insert( roseSeven )
    sceneGroup:insert( roseEight )
    sceneGroup:insert( roseNine )
    sceneGroup:insert( roseTen )
    sceneGroup:insert( roseEleven )
    sceneGroup:insert( roseTwelve )
    sceneGroup:insert( rosella )
    sceneGroup:insert( backgroundColour )
    sceneGroup:insert( backgroundColour2 )
    sceneGroup:insert( loadingText )

end 

--------------------------------------------------------------------------------------------

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

    elseif ( phase == "did" ) then
        -- start the splash screen sound effect
        horseSoundChannel = audio.play(horseSound, {channel = 1})
        
        -- Call the moveRosella function as soon as we enter the frame
        Runtime:addEventListener("enterFrame", moveRosella) 

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 2000, gotoMainMenu)  

    end
end 

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
        
        -- stop the sound channel for this screen
        audio.stop(horseSoundChannel)
    end
end 

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
end 

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