-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local questionText

local firstNumber

local answerText
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3

local userAnswer

-- boolean variables telling me which answer box was touched
local answerboxAlreadyTouched = false
local wrongAnswerBox1AlreadyTouched = false
local wrongAnswerBox2AlreadyTouched = false
local wrongAnswerBox3AlreadyTouched = false

--create textboxes holding answer and wrong answers 
local answerbox
local wrongAnswerBox1
local wrongAnswerBox2
local wrongAnswerBox3

-- create variables that will hold the previous x- and y-positions so that 
-- each answer will return back to its previous position after it is moved
local answerboxPreviousY
local wrongAnswerBox1PreviousY
local wrongAnswerBox2PreviousY
local wrongAnswerBox3PreviousY

local answerboxPreviousX
local wrongAnswerBox1PreviousX
local wrongAnswerBox2PreviousX
local wrongAnswerBox3PreviousX

-- the black box where the user will drag the answer
local userAnswerBoxPlaceholder

--Number of correct/incorrect answers
local answersCorrect = 0
local answersIncorrect = 0

local answerPosition 
local bkg
local cover

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7


local correctAnswer

local correctSound = audio.loadSound("Sounds/Correct.wav")
local correctSoundChannel
local booSound = audio.loadSound("Sounds/boo.mp3")
local booSoundChannel

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 400 )
    ResumeGame()
end 

-----------------------------------------------------------------------------------------
local function DisplayQuestion()

    local randomNumber1

  randomNumber1 = math.random(1,10)

  randomNumber1 = 1

  if (randomNumber1 == 1) then 
      -- create the question text object
      questionText = display.newText("What is \"dog\" in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)


      answerbox.text = "Chien"
      wrongAnswerBox1.text = "Chat"
      wrongAnswerBox2.text = "Oiseau"
      wrongAnswerBox3.text = "Souris"


  elseif (randomNumber1 == 2) then 
      -- create the question text object
      questionText = display.newText("What is red in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)

      answerbox = display.newText("Rouge", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Noir", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Brun", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Rose", display.contentWidth * 0.9, 0, nil, 65)


  elseif (randomNumber1 == 3) then 
      -- create the question text object
      questionText = display.newText("What is the number five in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 65)
 
      answerbox = display.newText("Cinq", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Trois", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Deux", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Dix", display.contentWidth * 0.9, 0, nil, 65)
  
    elseif (randomNumber1 == 4) then 
      -- create the question text object
      questionText = display.newText("What is spring in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)
 
      answerbox = display.newText("Printemps", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Hiver", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Automne", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Froid", display.contentWidth * 0.9, 0, nil, 65)
    
    elseif (randomNumber1 == 5) then 
      -- create the question text object
      questionText = display.newText("What is Germany in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)
 
      answerbox = display.newText("Allemagne", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Canada", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Mexique", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Angleterre", display.contentWidth * 0.9, 0, nil, 65)


    elseif (randomNumber1 == 6) then 
      -- create the question text object
      questionText = display.newText("What is you are drawing in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 65)
 
      answerbox = display.newText("Tu dessines", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Je dessine", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Vous dessinez", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Nous dessinons", display.contentWidth * 0.9, 0, nil, 65)


    elseif (randomNumber1 == 7) then 
      -- create the question text object
      questionText = display.newText("What is I am eating in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 65)
 
      answerbox = display.newText("Je mange", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Tu manges", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Il mange", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Vous mangez", display.contentWidth * 0.9, 0, nil, 65)


    elseif (randomNumber1 == 8) then 
      -- create the question text object
      questionText = display.newText("What is we are running in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 65)
 
      answerbox = display.newText("Nous courrons", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Tu cours", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Vous courez", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Il court", display.contentWidth * 0.9, 0, nil, 65)


    elseif (randomNumber1 == 9) then 
      -- create the question text object
      questionText = display.newText("What is she is walking in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 65)
 
      answerbox = display.newText("Elle marche", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Tu marches", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Je marches", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Vous marchez", display.contentWidth * 0.9, 0, nil, 63)


    elseif (randomNumber1 == 10) then 
      -- create the question text object
      questionText = display.newText("What is he is playing in French?", display.contentCenterX, display.contentCenterY*3/8, Arial, 65)
 
      answerbox = display.newText("Il joue", 800, 500, nil, 65)
      wrongAnswerBox1 = display.newText("Tu joues", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox2 = display.newText("Vous jouez", display.contentWidth * 0.9, 0, nil, 65)
      wrongAnswerBox3 = display.newText("Elle joue", display.contentWidth * 0.9, 0, nil, 65)
    end

   -------------------------------------------------------------------------------------------
   -- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
   -- placed into the black box)
   -----------------------------------------------------------------------------------------
    answerbox.x = 800
    wrongAnswerBox1.x = 250
    wrongAnswerBox2.x = 800
    wrongAnswerBox3.x = 250

    answerbox.y = 500
    wrongAnswerBox1.y = 500
    wrongAnswerBox2.y = 650
    wrongAnswerBox3.y = 650

    -- make it possible to click on the answers again
    answerboxAlreadyTouched = false
    alternateAnswerBox1AlreadyTouched = false
    alternateAnswerBox2AlreadyTouched = false
    alternateAnswerBox3AlreadyTouched = false

end

local function PositionAnswers()
    local randomPosition

    -------------------------------------------------------------------------------------------
    --ROMDOMLY SELECT ANSWER BOX POSITIONS
    -----------------------------------------------------------------------------------------
    randomPosition = math.random(1,4)

    -- random position 1
    if (randomPosition == 1) then
        -- set the new y-positions of each of the answers
        answerbox.y = Y1
        answerbox.x = X1

        --wrongAnswerBox1
        wrongAnswerBox1.y = Y1
        wrongAnswerBox1.x = X2

        --wrongAnswerBox2
        wrongAnswerBox2.y = Y2
        wrongAnswerBox2.x = X1


        --wrongAnswerBox3
        wrongAnswerBox3.y = Y2
        wrongAnswerBox3.x = X2

        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
        answerboxPreviousY = answerbox.y 

    -- random position 2
    elseif (randomPosition == 2) then

        answerbox.y = Y1
        answerbox.x = X2

        --wrongAnswerBox1
        wrongAnswerBox1.y = Y1
        wrongAnswerBox1.x = X1
        
        --wrongAnswerBox2
        wrongAnswerBox2.y = Y2
        wrongAnswerBox2.x = X2


        --wrongAnswerBox3
        wrongAnswerBox3.y = Y2
        wrongAnswerBox3.x = X1

        --remembering their positions to return the answer in case it's wrong
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
        answerboxPreviousY = answerbox.y 

    -- random position 3
     elseif (randomPosition == 3) then
        answerbox.y = Y2
        answerbox.x = X2

        --wrongAnswerBox1
        wrongAnswerBox1.y = X2
        wrongAnswerBox1.x = Y1

        --wrongAnswerBox2
        wrongAnswerBox2.y = Y1
        wrongAnswerBox2.x = X1


        --AnswerBox3
        wrongAnswerBox3.y = Y1
        wrongAnswerBox3.x = Y2

        --remembering their positions to return the answer in case it's wrong
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
        answerboxPreviousY = answerbox.y 

            -- random position 4
     elseif (randomPosition == 4) then
        answerbox.y = X2
        answerbox.x = Y1

        --wrongAnswerBox2
        wrongAnswerBox1.y = Y2
        wrongAnswerBox1.x = X2

        --wrongAnswerBox1
        wrongAnswerBox2.y = Y1
        wrongAnswerBox2.x = Y2


        --wrongAnswerBox3
        wrongAnswerBox3.y = Y1
        wrongAnswerBox3.x = X1

        --remembering their positions to return the answer in case it's wrong
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
        answerboxPreviousY = answerbox.y 

    end
end



-- Function to Check User Input to see if answers are correct or incorrect
local function CheckUserAnswerInput()
    if (userAnswer == correctAnswer) then 
        correctSoundChannel = audio.play(correctSound)
    elseif (userAnswer == wrongAnswer1) then 
        answersIncorrect = answersIncorrect + 1
        booSoundChannel = audio.play(booSound)
        timer.performWithDelay(1600, RestartLevel1)
    elseif (userAnswer == wrongAnswer2) then 
        answersIncorrect = answersIncorrect + 1
        booSoundChannel = audio.play(booSound)
        timer.performWithDelay(1600, RestartLevel1)
    elseif (userAnswer == wrongAnswer3) then 
        answersIncorrect = answersIncorrect + 1
        booSoundChannel = audio.play(booSound)
        timer.performWithDelay(1600, RestartLevel1)
    end 

    --Answers correct needed to win
    if  (answersIncorrect == 2) then 
        timer.performWithDelay(1600, YouLoseTransitionLevel1) 
    --Answers incorrect needed to lose
    elseif (answersCorrect == 3) then 
        timer.performWithDelay(1600, YouWinTransitionLevel1) 
    end
end 

local function TouchListenerAnswerbox(touch)
    --only work if none of the other boxes have been touched
    if (wrongAnswerBox1AlreadyTouched == false) and 
        (wrongAnswerBox2AlreadyTouched == false) and
        (wrongAnswerBox3AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            answerboxAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            answerbox.x = touch.x
            answerbox.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            answerboxAlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < answerbox.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > answerbox.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < answerbox.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > answerbox.y ) ) then

                -- setting the position of the number to be in the center of the box
                answerbox.x = userAnswerBoxPlaceholder.x
                answerbox.y = userAnswerBoxPlaceholder.y
                userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                answerbox.x = answerboxPreviousX
                answerbox.y = answerboxPreviousY
            end
        end
    end                
end 

local function TouchListenerAnswerBox1(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (wrongAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            wrongAnswerBox1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            wrongAnswerBox1.x = touch.x
            wrongAnswerBox1.y = touch.y

        elseif (touch.phase == "ended") then
           wrongAnswerBox1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < wrongAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > wrongAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < wrongAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > wrongAnswerBox1.y ) ) then

                wrongAnswerBox1.x = userAnswerBoxPlaceholder.x
                wrongAnswerBox1.y = userAnswerBoxPlaceholder.y
                userAnswer = wrongAnswer1

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                wrongAnswerBox1.x = wrongAnswerBox1PreviousX
                wrongAnswerBox1.y = wrongAnswerBox1PreviousY
            end
        end
    end
end 

local function TouchListenerAnswerBox2(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (wrongAnswerBox1AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            wrongAnswerBox2AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            wrongAnswerBox2.x = touch.x
            wrongAnswerBox2.y = touch.y

        elseif (touch.phase == "ended") then
            wrongAnswerBox2AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < wrongAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > wrongAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < wrongAnswerBox2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > wrongAnswerBox2.y ) ) then

                wrongAnswerBox2.x = userAnswerBoxPlaceholder.x
                wrongAnswerBox2.y = userAnswerBoxPlaceholder.y
                userAnswer = wrongAnswer2

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                wrongAnswerBox2.x = wrongAnswerBox2PreviousX
                wrongAnswerBox2.y = wrongAnswerBox2PreviousY
            end
        end
    end
end 


local function TouchListenerAnswerBox3(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (wrongAnswerBox1AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            wrongAnswerBox3AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            wrongAnswerBox3.x = touch.x
            wrongAnswerBox3.y = touch.y

        elseif (touch.phase == "ended") then
            wrongAnswerBox3AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < wrongAnswerBox3.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > wrongAnswerBox3.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < wrongAnswerBox3.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > wrongAnswerBox3.y ) ) then

                wrongAnswerBox3.x = userAnswerBoxPlaceholder.x
                wrongAnswerBox3.y = userAnswerBoxPlaceholder.y
                userAnswer = wrongAnswer3

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                wrongAnswerBox3.x = wrongAnswerBox3PreviousX
                wrongAnswerBox3.y = wrongAnswerBox3PreviousY
            end
        end
    end
end 



-- Function that Adds Listeners to each answer box
local function AddAnswerBoxEventListeners()
    answerbox:addEventListener("touch", TouchListenerAnswerbox)
    wrongAnswerBox1:addEventListener("touch", TouchListenerAnswerBox1)
    wrongAnswerBox2:addEventListener("touch", TouchListenerAnswerBox2)
    wrongAnswerBox3:addEventListener("touch", TouchListenerAnswerBox3)
end 

-- Function that Removes Listeners to each answer box
local function RemoveAnswerBoxEventListeners()
    answerbox:removeEventListener("touch", TouchListenerAnswerbox)
    wrongAnswerBox1:removeEventListener("touch", TouchListenerAnswerBox1)
    wrongAnswerBox2:removeEventListener("touch", TouchListenerAnswerBox2)
    wrongAnswerBox3:removeEventListener("touch", TouchListenerAnswerBox3)
end 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.8)

    -----------------------------------------------------------------------------------------
    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.9, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(220/255, 195/255, 32/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)

    --create answerbox wrong answers and the boxes to show them
    answerbox = display.newText("", X1, Y1, nil, 75)
    wrongAnswerBox1 = display.newText("", X2, Y2, nil, 75)
    wrongAnswerBox2 = display.newText("", X2, Y1, nil, 75)
    wrongAnswerBox3 = display.newText("", X1, Y2, nil, 75)

    -- set the x positions of each of the answer boxes
    answerboxPreviousX = 500
    wrongAnswerBox1PreviousX = display.contentWidth * 0.9
    wrongAnswerBox2PreviousX = display.contentWidth * 0.9
    wrongAnswerBox3PreviousX = display.contentWidth * 0.9

    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/PinkBackground.png", 400, 150, 0, 0)
    userAnswerBoxPlaceholder.x = 500
    userAnswerBoxPlaceholder.y = 300

    -- boolean variables stating whether or not the answer was touched
    answerboxAlreadyTouched = false
    wrongAnswerBox1AlreadyTouched = false
    wrongAnswerBox2AlreadyTouched = false
    wrongAnswerBox3AlreadyTouched = false



    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( answerbox )
    sceneGroup:insert( wrongAnswerBox1 )
    sceneGroup:insert( wrongAnswerBox2 )
    sceneGroup:insert( wrongAnswerBox3 )


end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        DisplayQuestion()
        PositionAnswers()
        AddAnswerBoxEventListeners()
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveAnswerBoxEventListeners()
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup"). 
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

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