-----------------------------------------------------------------------------------------
-- main.lua
-- Created by: Sasha Malko
-- Date: May 4, 2018
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

--hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )
-----------------------------------------------------------------------------------------

-- Go to the splash screen
composer.gotoScene( "level2_screen" )