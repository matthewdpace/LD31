-- Ludum Dare 31 Entry
-- Matthew Pace and Andrew Donato
-- Last modified 2014-12-06

ButtonManager = require('src/ButtonManager')
BM = ButtonManager.new()

DrawManager = require('src/DrawManager')
DM = DrawManager.new()



Submarine = require('src/Submarine')
S = Submarine.new()

GAMEMODE = "PLAY"

local displayModes = {'COMPASS', 'ROOMS'}

function love.conf(t)
  t.window.width = 800
  t.window.height = 600
  t.modules.joystick = false
  t.modules.physics = false
  t.window.title = "untitled LD31 entry"
end

function love.load(arg)
  -- do shit
  mainFont = love.graphics.newFont('Hyperspace Bold.ttf', 15)
  love.graphics.setBackgroundColor(120,120,120)
  
  ---[[
  if arg[#arg] == "-debug" then 
    require("mobdebug").start()
  end
--]]
end

function love.draw()
  
  if GAMEMODE == "MENU" then
    -- do some shit
  end
  if GAMEMODE == "PAUSE" then
    -- do some shit
  end
  
  if GAMEMODE == "PLAY" then
    --call draw manager shit
    DM:drawBase()
  end
  

  --DM:flip()
  
end

function love.update(dt)
  --if s.
  
end

function love.mousereleased(mx, my, btn)
  if GAMEMODE == "PLAY" then
    BM:process(x,y)
  end
end
