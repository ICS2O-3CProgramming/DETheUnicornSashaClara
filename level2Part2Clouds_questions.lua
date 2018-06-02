-----------------------------------------------------------------------------------------
-- level1Clouds_screen.lua
-- Created by: Sasha Malko
-- Date: May 14, 2018
-- Description: This is the level 1 questions of the game. The unicorn must jump from rainbow 
--to rainbow, and if you it hits an obstacle, the user must answer a question.
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------
-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2Part2Clouds_questions"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local questionText
local bkg
local cover
local correctText
local incorrectText
local randomNumber1
local randomPosition 

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
local answerboxPreviousX
local wrongAnswerBox1PreviousX
local wrongAnswerBox2PreviousX
local wrongAnswerBox3PreviousX

local answerboxPreviousY
local wrongAnswerBox1PreviousY
local wrongAnswerBox2PreviousY
local wrongAnswerBox3PreviousY

-- the black box where the user will drag the answer
local userAnswerBoxPlaceholder

-- The position of the text
local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*5/7
local Y1 = display.contentHeight*4/7
local Y2 = display.contentHeight*6/7

--Sounds
local correctSound = audio.loadSound("Sounds/Correct.mp3")
local correctSoundChannel
local incorrectSound = audio.loadSound("Sounds/Incorrect.mp3")
local incorrectSoundChannel

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--Making transition back to level
local function BackToLevel1() 
  composer.hideOverlay("crossFade", 400 )

    --Checking what character the user chose and placing it on the screen
    if (characterChoice == "pinkUnicorn") then
      character = display.newImageRect("Images/RectangularUnicorn.png", 100, 150)
    elseif (characterChoice == "blueUnicorn") then
      character = display.newImageRect("Images/BlueUnicorn.png", 100, 150)
    elseif (characterChoice == "bowUnicorn") then
      character = display.newImageRect("Images/BowUnicorn.png", 100, 150)
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
  
    AddL2P2()
end 

-----------------------------------------------------------------------------------------

--Function which displays the questions and answers
local function DisplayQuestionAndAnswers()

  randomNumber1 = math.random(1,10) 

  if (randomNumber1 == 1) then 

      -- create the question text object
      questionText.text = "What is \"dog\" in French?"

      --create the answers
      answerbox.text = "Chien"
      wrongAnswerBox1.text = "Chat"
      wrongAnswerBox2.text = "Oiseau"
      wrongAnswerBox3.text = "Souris"


  elseif (randomNumber1 == 2) then 

      -- create the question text object
      questionText.text = "What is \"red\" in French?"

      --create the answers
      answerbox.text = "Rouge"
      wrongAnswerBox1.text = "Noir"
      wrongAnswerBox2.text = "Blanc"
      wrongAnswerBox3.text = "Orange"

  elseif (randomNumber1 == 3) then 
      -- create the question text object
      questionText.text = "What is the number \"five\" in French?"
 
      --create the answers
      answerbox.text = "Cinq"
      wrongAnswerBox1.text = "Trois"
      wrongAnswerBox2.text = "Deux"
      wrongAnswerBox3.text = "Six"
  
    elseif (randomNumber1 == 4) then 
      -- create the question text object
      questionText.text = "What is \"spring\" in French?"
 
      --create the answers
      answerbox.text = "Printemps"
      wrongAnswerBox1.text = "Automne"
      wrongAnswerBox2.text = "Hiver"
      wrongAnswerBox3.text = "Froid"
    
    elseif (randomNumber1 == 5) then 
      -- create the question text object
      questionText.text = "What is \"Germany\" in French?"
 
      --create the answers
      answerbox.text = "Allemagne"
      wrongAnswerBox1.text = "Canada"
      wrongAnswerBox2.text = "Mexique"
      wrongAnswerBox3.text = "Angleterre"


    elseif (randomNumber1 == 6) then 
      -- create the question text object
      questionText.text = "What is \"you are drawing\" in French?"
 
      --create the answers
      answerbox.text = "Tu dessines"
      wrongAnswerBox1.text = "Je dessine"
      wrongAnswerBox2.text = "Il dessine"
      wrongAnswerBox3.text = "Nous dessinons"


    elseif (randomNumber1 == 7) then 
      -- create the question text object
      questionText.text = "What is \"I am eating\" in French?"
 
      --create the answers
      answerbox.text = "Je mange"
      wrongAnswerBox1.text = "Tu manges"
      wrongAnswerBox2.text = "Il mange"
      wrongAnswerBox3.text = "Vous mangez"


    elseif (randomNumber1 == 8) then 
      -- create the question text object
      questionText.text = "What is \"we are running\" in French?"
 
      --create the answers
      answerbox.text = "Nous courons"
      wrongAnswerBox1.text = "Tu cours"
      wrongAnswerBox2.text = "Vous courez"
      wrongAnswerBox3.text = "Il court"


    elseif (randomNumber1 == 9) then 
      -- create the question text object
      questionText.text = "What is \"she is walking\" in French?"
 
      --create the answers
      answerbox.text = "Elle marche"
      wrongAnswerBox1.text = "Tu marches"
      wrongAnswerBox2.text = "Je marche"
      wrongAnswerBox3.text= "Vous marchez"


    elseif (randomNumber1 == 10) then 
      -- create the question text object
      questionText.text = "What is \"he is playing\" in French?"
 
      --create the answers
      answerbox.text = "Il joue"
      wrongAnswerBox1.text = "Tu joues"
      wrongAnswerBox2.text = "Vous jouez"
      wrongAnswerBox3.text= "Elle joue"
    end

end

local function PositionAnswers()
    -------------------------------------------------------------------------------------------
    --ROMDOMLY SELECT ANSWER BOX POSITIONS
    -----------------------------------------------------------------------------------------
    randomPosition = math.random(1,4)

    -- random position 1
    if (randomPosition == 1) then

         -- answer box position
        answerbox.x = X1
        answerbox.y = Y1
        
        --wrongAnswerBox1 position
        wrongAnswerBox1.x = X1
        wrongAnswerBox1.y = Y2

        --wrongAnswerBox2 position
        wrongAnswerBox2.x = X2
        wrongAnswerBox2.y = Y2
        
        --wrongAnswerBox3
        wrongAnswerBox3.x = X2
        wrongAnswerBox3.y = Y1
        
        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        answerboxPreviousX = answerbox.x
        wrongAnswerBox1PreviousX = wrongAnswerBox1.x
        wrongAnswerBox2PreviousX = wrongAnswerBox2.x
        wrongAnswerBox3PreviousX = wrongAnswerBox3.x
         
        answerboxPreviousY = answerbox.y
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
         

    -- random position 2
    elseif (randomPosition == 2) then

        -- answer box position
        answerbox.x = X2
        answerbox.y = Y1
        

        --wrongAnswerBox1 position
        wrongAnswerBox1.x = X1
        wrongAnswerBox1.y = Y1
        
        
        --wrongAnswerBox2 position
        wrongAnswerBox2.x = X1
        wrongAnswerBox2.y = Y2
        

        --wrongAnswerBox3 position
        wrongAnswerBox3.x = X2
        wrongAnswerBox3.y = Y2

        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        answerboxPreviousX = answerbox.x
        wrongAnswerBox1PreviousX = wrongAnswerBox1.x
        wrongAnswerBox2PreviousX = wrongAnswerBox2.x
        wrongAnswerBox3PreviousX = wrongAnswerBox3.x
         
        answerboxPreviousY = answerbox.y
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
         
       
      -- random position 3
     elseif (randomPosition == 3) then

        -- answer box position
        answerbox.x = X2
        answerbox.y = Y2
        
        --wrongAnswerBox1 position
        wrongAnswerBox1.x = X2
        wrongAnswerBox1.y = Y1
        
        --wrongAnswerBox2 position
         wrongAnswerBox2.x = X1
        wrongAnswerBox2.y = Y1
       
        --AnswerBox3 position
        wrongAnswerBox3.x = X1
        wrongAnswerBox3.y = Y2

        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        answerboxPreviousX = answerbox.x
        wrongAnswerBox1PreviousX = wrongAnswerBox1.x
        wrongAnswerBox2PreviousX = wrongAnswerBox2.x
        wrongAnswerBox3PreviousX = wrongAnswerBox3.x
         
        answerboxPreviousY = answerbox.y
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y
       

        -- random position 4
     elseif (randomPosition == 4) then

        -- answer box position
        answerbox.x = X1
        answerbox.y = Y2
        
        --wrongAnswerBox2 position
        wrongAnswerBox1.x = X2
        wrongAnswerBox1.y = Y2
        
        --wrongAnswerBox1 position
        wrongAnswerBox2.x = X2
        wrongAnswerBox2.y = Y1
        
        --wrongAnswerBox3 position
        wrongAnswerBox3.x = X1
        wrongAnswerBox3.y = Y1
        
        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        answerboxPreviousX = answerbox.x
        wrongAnswerBox1PreviousX = wrongAnswerBox1.x
        wrongAnswerBox2PreviousX = wrongAnswerBox2.x
        wrongAnswerBox3PreviousX = wrongAnswerBox3.x
         
        answerboxPreviousY = answerbox.y
        wrongAnswerBox1PreviousY = wrongAnswerBox1.y
        wrongAnswerBox2PreviousY = wrongAnswerBox2.y
        wrongAnswerBox3PreviousY = wrongAnswerBox3.y 

    end
end

--Function to restart the question
local function RestartQuestion()
  DisplayQuestionAndAnswers()
  PositionAnswers()
end

--Function to hide the correct answer
local function HideCorrect()
  correctText.isVisible = false
end

--Function to hide the incorrect answer
local function HideIncorrect()
  incorrectText.isVisible = false
end

--Function to transition to the you lose screen
local function YouLoseTransition()
composer.gotoScene( "you_lose" )
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

            --reset the answer so it has not been touched
            answerboxAlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < answerbox.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > answerbox.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < answerbox.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > answerbox.y ) ) then

                -- setting the position of the number to be in the center of the box
                answerbox.x = userAnswerBoxPlaceholder.x
                answerbox.y = userAnswerBoxPlaceholder.y

                -- Play correct Sound 
                correctSoundChannel = audio.play(correctSound)
                
                --Make the correct text visible
                correctText.isVisible = true

                --Hide the correct text
                timer.performWithDelay(1000,HideCorrect)

                --Go back to level 1 
                BackToLevel1()

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
        (wrongAnswerBox2AlreadyTouched == false) and 
        (wrongAnswerBox3AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            wrongAnswerBox1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            wrongAnswerBox1.x = touch.x
            wrongAnswerBox1.y = touch.y

        elseif (touch.phase == "ended") then

           --reset the answer so it has not been touched
           wrongAnswerBox1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < wrongAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > wrongAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < wrongAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > wrongAnswerBox1.y ) ) then

                -- setting the position of the number to be in the center of the box
                wrongAnswerBox1.x = userAnswerBoxPlaceholder.x
                wrongAnswerBox1.y = userAnswerBoxPlaceholder.y

                -- Play incorrect Sound
                incorrectSoundChannel = audio.play(incorrectSound)
                 
                --Lose a heart if you the answer is incorrect
                if (heart10.isVisible == true) and 
                   (heart11.isVisible == true) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false
                   heart11.isVisible = true
                   heart12.isVisible = true
                   --make the incorrect text visible
                   incorrectText.isVisible = true
                   --Hide the incorrect text
                   timer.performWithDelay(1000,HideIncorrect)
                   --Backt to level 1 
                   BackToLevel1()

                --Lose a heart if you the answer is incorrect
                elseif (heart10.isVisible == false) and 
                   (heart11.isVisible == true) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false 
                   heart11.isVisible = false
                   heart12.isVisible = true
                   --make the incorrect text visible
                   incorrectText.isVisible = true
                   --Hide the incorrect text
                   timer.performWithDelay(1000,HideIncorrect)
                   --Backt to level 1 
                   BackToLevel1()
                
                 --Lose a heart if you the answer is incorrect
                 elseif (heart10.isVisible == false) and 
                   (heart11.isVisible == false) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false 
                   heart11.isVisible = false
                   heart12.isVisible = false
                   --You lose transition
                   YouLoseTransition()
                   
                end
                
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
        (wrongAnswerBox1AlreadyTouched == false) and 
        (wrongAnswerBox3AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            wrongAnswerBox2AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            wrongAnswerBox2.x = touch.x
            wrongAnswerBox2.y = touch.y

        elseif (touch.phase == "ended") then

            --reset the answer so it has not been touched
            wrongAnswerBox2AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < wrongAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > wrongAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < wrongAnswerBox2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > wrongAnswerBox2.y ) ) then

                -- setting the position of the number to be in the center of the box
                wrongAnswerBox2.x = userAnswerBoxPlaceholder.x
                wrongAnswerBox2.y = userAnswerBoxPlaceholder.y

                -- Play incorrect Sound
                incorrectSoundChannel = audio.play(incorrectSound)
                
                --Lose a heart if you the answer is incorrect
                if (heart10.isVisible == true) and 
                   (heart11.isVisible == true) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false
                   heart11.isVisible = true
                   heart12.isVisible = true
                   --make the incorrect text visible
                   incorrectText.isVisible = true
                   --Hide the incorrect text
                   timer.performWithDelay(1000,HideIncorrect)
                   --Backt to level 1 
                   BackToLevel1()

                --Lose a heart if you the answer is incorrect
                elseif (heart10.isVisible == false) and 
                   (heart11.isVisible == true) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false 
                   heart11.isVisible = false
                   heart12.isVisible = true
                   --make the incorrect text visible
                   incorrectText.isVisible = true
                   --Hide the incorrect text
                   timer.performWithDelay(1000,HideIncorrect)
                   --Backt to level 1 
                   BackToLevel1()
                
                 --Lose a heart if you the answer is incorrect
                 elseif (heart10.isVisible == false) and 
                   (heart11.isVisible == false) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false 
                   heart11.isVisible = false
                   heart12.isVisible = false
                   --You lose transition
                   YouLoseTransition()
                   
                end
                
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
        (wrongAnswerBox1AlreadyTouched == false) and
        (wrongAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            wrongAnswerBox3AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            wrongAnswerBox3.x = touch.x
            wrongAnswerBox3.y = touch.y

        elseif (touch.phase == "ended") then

            --reset the answer so it has not been touched
            wrongAnswerBox3AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < wrongAnswerBox3.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > wrongAnswerBox3.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < wrongAnswerBox3.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > wrongAnswerBox3.y ) ) then

                -- setting the position of the number to be in the center of the box
                wrongAnswerBox3.x = userAnswerBoxPlaceholder.x
                wrongAnswerBox3.y = userAnswerBoxPlaceholder.y

                -- Play incorrect Sound
                incorrectSoundChannel = audio.play(incorrectSound)
                
                --Lose a heart if you the answer is incorrect
                if (heart10.isVisible == true) and 
                   (heart11.isVisible == true) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false
                   heart11.isVisible = true
                   heart12.isVisible = true
                   --make the incorrect text visible
                   incorrectText.isVisible = true
                   --Hide the incorrect text
                   timer.performWithDelay(1000,HideIncorrect)
                   --Backt to level 1 
                   BackToLevel1()

                --Lose a heart if you the answer is incorrect
                elseif (heart10.isVisible == false) and 
                   (heart11.isVisible == true) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false 
                   heart11.isVisible = false
                   heart12.isVisible = true
                   --make the incorrect text visible
                   incorrectText.isVisible = true
                   --Hide the incorrect text
                   timer.performWithDelay(1000,HideIncorrect)
                   --Backt to level 1 
                   BackToLevel1()
                
                --Lose a heart if you the answer is incorrect
                 elseif (heart10.isVisible == false) and 
                   (heart11.isVisible == false) and 
                   (heart12.isVisible == true) then 
                   heart10.isVisible = false 
                   heart11.isVisible = false
                   heart12.isVisible = false
                   --You lose transition
                   YouLoseTransition()
                   
                end
                
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

    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.9, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(220/255, 195/255, 32/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 60)

    --create answerbox wrong answers and the boxes to show them
    answerbox = display.newText("", X1, Y1, nil, 60)
    wrongAnswerBox1 = display.newText("", X1, Y2, nil, 60)
    wrongAnswerBox2 = display.newText("", X2, Y2, nil, 60)
    wrongAnswerBox3 = display.newText("", X2, Y1, nil, 60)

    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/PinkBackground.png", 400, 150, 0, 0)
    userAnswerBoxPlaceholder.x = 500
    userAnswerBoxPlaceholder.y = 300

    -- boolean variables stating whether or not the answer was touched
    answerboxAlreadyTouched = false
    wrongAnswerBox1AlreadyTouched = false
    wrongAnswerBox2AlreadyTouched = false
    wrongAnswerBox3AlreadyTouched = false

    -- create the correct text object
    correctText = display.newText("Correct", display.contentCenterX, display.contentCenterY, Arial, 70)
    correctText:setTextColor(39/255, 107/255, 13/255)
    correctText.isVisible = false

    -- create the incorrect text object
    incorrectText = display.newText("Incorrect", display.contentCenterX, display.contentCenterY, Arial, 70)
    incorrectText:setTextColor(107/255, 13/255, 13/255)
    incorrectText.isVisible = false
    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(userAnswerBoxPlaceholder)
    sceneGroup:insert(answerbox)
    sceneGroup:insert(wrongAnswerBox1)
    sceneGroup:insert(wrongAnswerBox2)
    sceneGroup:insert(wrongAnswerBox3)
    sceneGroup:insert(correctText)
    sceneGroup:insert(incorrectText)
    sceneGroup:insert(questionText)



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

    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    elseif ( phase == "did" ) then

        --Restart the question
        RestartQuestion()

        --Add the listeners to the answers boxes
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

    -- Called when the scene is on screen (but is about to go off screen).
    if ( phase == "will" ) then

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
      
      --Remove the listeners for the answers boxes
      RemoveAnswerBoxEventListeners()

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