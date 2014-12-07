-- merchant game



Items = require('items')
Heroes = require('heroes')
Shop = require('shop')
Events = require('events')
Menu = require('menu')
Text = require ('text')

currentDay = {}
currentHero = {}

heroList = {}

NPCText = {}

function love.load(arg)
  Player = Shop.new()
  Menu = Menu.new()
  MODE = "INTRO"
  textFunction = Text.intro
  --displayText = TEXTS.intro
  love.graphics.setBackgroundColor(120,120,120)
  menuFont = love.graphics.newFont('Triforce.ttf', 24)
  newsTitleFont = love.graphics.newFont('IHATCS__.ttf', 42)
  newsTextFont = love.graphics.newFont('IHATCS__.ttf', 24)
  --if arg[#arg] == "-debug" then require("mobdebug").start() end
  NPCText.enabled = true
  NPCText.text = "This is just a test message"
end


function generateDay()
  -- generate number of heroes who will shop today
  currentDay.heroCnt = math.random(5)
  
  -- see if there's any events today
end

function getOrGenerateHero()
  local availHeroes = {}
  
  for _,v in ipairs(heroList) do
    if v.isAvailable then
      table.insert(availHeroes, v)
    end
  end
  
  if len(availHeroes) > 2 then
    if math.random(100) > 60 then
      currentHero = availHeroes[math.random(len(availHeroes))]
    end
  end
  currentHero = Heroes:generateNewHero()
end

function love.draw()
  --if MODE == 'PLAY' then
    love.graphics.clear()
    love.graphics.setColor(0,0,0,200)
    love.graphics.rectangle('fill', 0,500, 1280, 500)
    love.graphics.setColor(220,220,220)
    love.graphics.setLineWidth(3)
    love.graphics.line(0, 500, 1280, 500)  
  --end
  if MODE == "NEWDAY" then
    -- display news
    -- draw newspaper
    love.graphics.setColor(200,200,200)
    love.graphics.rectangle('fill', 230,30,500,400)
    love.graphics.setColor(10,10,10)
    love.graphics.setFont(newsTitleFont)
    love.graphics.printf("Townie News", 220, 80, 600, 'center')
    love.graphics.setFont(newsTextFont)
    love.graphics.print("Some shit went down and some people got killed", 250, 120)
  end
  
  -- text box
  
  love.graphics.setFont(menuFont)
  love.graphics.setColor(220,220,220)
  --love.graphics.printf(displayText, 20, 520, 1240, 'left')
  textFunction()

    -- NPC text box
  if NPCText.enabled then
    love.graphics.setFont(menuFont)
    love.graphics.setColor(120,120,120, 10)
    love.graphics.rectangle('fill',700, 200, 850, 350)
    love.graphics.setColor(200,200,200)
    love.graphics.print(NPCText.text, 760,210)
  end
  
end



-- DEBUG
--[[
function love.keypressed(key, u)
   --Debug
   if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end
end

--]]

function love.keyreleased(key, u)
  if key == "return" or key == "kpenter" then
    if MODE == "INTRO" then
      MODE = "NEWDAY"
      generateDay()
      textFunction = Text.pressEnter
    
  elseif MODE == "NEWDAY" then
    MODE = "PLAY"
    textFunction = Text.none
    getOrGenerateHero()
    -- generate a hero to use
    

  
  elseif MODE == "PLAY" then
    Menu:processKey(key)
  end
  
  end
end
