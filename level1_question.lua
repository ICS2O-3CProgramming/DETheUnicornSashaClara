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

local answer
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
    local randomNumber2

    --set random numbers
    randomNumber1 = math.random(5, 20)
    randomNumber2 = math.random(5, 20)

    --calculate answer
    correctAnswer = randomNumber1 + randomNumber2

    --change question text in relation to answer
    questionText.text = randomNumber1 .. " + " .. randomNumber2 .. " = " 

    -- put the correct answer into the answerbox
    answerbox.text = correctAnswer

    -- make it possible to click on the answers again
    answerboxAlreadyTouched = false
    wrongAnswerBox1AlreadyTouched = false
    wrongAnswerBox2AlreadyTouched = false
    wrongAnswerBox3AlreadyTouched = false

   
            
    -- generate incorrect answer and set it in the textbox
    wrongAnswer1 = correctAnswer + math.random(3, 5)
    wrongAnswerBox1.text = wrongAnswer1

    -- generate incorrect answer and set it in the textbox
    wrongAnswer2 = correctAnswer + math.random(1, 2)
    wrongAnswerBox2.text = wrongAnswer2

    -- generate incorrect answer and set it in the textbox
    wrongAnswer3 = correctAnswer + math.random(6, 8)
    wrongAnswerBox3.text = wrongAnswer3


    -------------------------------------------------------------------------------------------
   -- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
   -- placed into the black box)
   -----------------------------------------------------------------------------------------
    answerbox.x = display.contentWidth * 0.1
    wrongAnswerBox1.x = display.contentWidth * 0.1
    wrongAnswerBox2.x = display.contentWidth * 0.1
    wrongAnswerBox3.x = display.contentWidth * 0.1

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
        answerbox.y = display.contentHeight * 0.4

        --wrongAnswerBox2
        wrongAnswerBox2.y = display.contentHeight * 0.70

        --wrongAnswerBox1
        wrongAnswerBox1.y = display.contentHeight * 0.55

        --wrongAnswerBox3
        wrongAnswerBox3.y = display.contentHeight * 0.85

        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        answerboxPreviousY = answerbox.y 

    -- random position 2
    elseif (randomPosition == 2) then

        answerbox.y = display.contentHeight * 0.55
        
        --wrongAnswerBox2
        wrongAnswerBox2.y = display.contentHeight * 0.4

        --wrongAnswerBox1
        wrongAnswerBox1.y = display.contentHeight * 0.85


        --wrongAnswerBox3
        wrongAnswerBox3.y = display.contentHeight * 0.7

        --remembering their positions to return the answer in case it's wrong
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
        answerboxPreviousY = answerbox.y 

    -- random position 3
     elseif (randomPosition == 3) then
        answerbox.y = display.contentHeight * 0.70

        --wrongAnswerBox2
        wrongAnswerBox2.y = display.contentHeight * 0.85

        --wrongAnswerBox1
        wrongAnswerBox1.y = display.contentHeight * 0.4


        --AnswerBox3
        wrongAnswerBox3.y = display.contentHeight * 0.55

        --remembering their positions to return the answer in case it's wrong
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
        answerboxPreviousY = answerbox.y 

            -- random position 4
     elseif (randomPosition == 4) then
        answerbox.y = display.contentHeight * 0.85

        --wrongAnswerBox2
        wrongAnswerBox2.y = display.contentHeight * 0.7

        --wrongAnswerBox1
        wrongAnswerBox1.y = display.contentHeight * 0.55


        --wrongAnswerBox3
        wrongAnswerBox3.y = display.contentHeight * 0.4

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
        answersCorrect = answersCorrect + 1
        timer.performWithDelay(1600, RestartLevel1)
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
            print ("***Clicked")

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
                AnswerBox1.x = wrongAnswerBox1PreviousX
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
    cover:setFillColor(96/255, 96/255, 96/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)

    -- create the answer text object & wrong answer text objects
    answerText = display.newText("", X1, Y1, Arial, 75)
    answerText.anchorX = 0
    wrongText1 = display.newText("", X2, Y2, Arial, 75)
    wrongText1.anchorX = 0
    wrongText2 = display.newText("", X2, Y1, Arial, 75)
    wrongText2.anchorX = 0
    wrongText3 = display.newText("", X1, Y2, Arial, 75)
    wrongText3.anchorX = 0

    --create answerbox wrong answers and the boxes to show them
    answerbox = display.newText("", display.contentWidth * 0.9, 0, nil, 110)
    wrongAnswerBox1 = display.newText("", display.contentWidth * 0.9, 0, nil, 110)
    wrongAnswerBox2 = display.newText("", display.contentWidth * 0.9, 0, nil, 110)
    wrongAnswerBox3 = display.newText("", display.contentWidth * 0.9, 0, nil, 110)

    -- set the x positions of each of the answer boxes
    answerboxPreviousX = display.contentWidth * 0.9
    wrongAnswerBox1PreviousX = display.contentWidth * 0.9
    wrongAnswerBox2PreviousX = display.contentWidth * 0.9
    wrongAnswerBox3PreviousX = display.contentWidth * 0.9

        -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/PinkBackground.png", 130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = display.contentWidth * 0.9
    userAnswerBoxPlaceholder.y = display.contentHeight * 0.4

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
    sceneGroup:insert(answerText)
    sceneGroup:insert(wrongText1)
    sceneGroup:insert(wrongText2)
    sceneGroup:insert(wrongText3)
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