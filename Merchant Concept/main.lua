-- merchant game



item = require('item')
hero = require('hero')
shop = require('shop')
events = require('event')
menu = require('menu')
--Text = require ('text')
states = require('state')

currentDay = {}
heroSellingQueue = {}
heroBuyingQueue = {}
heroList = {}
heroQueue = {}
NPCText = {}

Shop = {}
Menu = {}
States = {}

function love.load(arg)

  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
  end
  States = states.new()
  Shop = shop.new()
  
  Menu = menu.new()
  --Heroes = hero.new()
  love.graphics.setBackgroundColor(120,120,120)
  bgImage = love.graphics.newImage('Merchant Built Stall Test_resized.png')
  
  newsTitleFont = love.graphics.newFont('IHATCS__.ttf', 42)
  newsTextFont = love.graphics.newFont('IHATCS__.ttf', 24)

  math.randomseed(os.time())
end


function generateDay()
  -- generate number of heroes who will shop today
  for i=1, math.random(10) do
    table.insert(heroQueue, getOrGenerateHero())
  -- see if there's any events today
  end
end


function getOrGenerateHero()
  local availHeroes = {}
  local currentHero
  for _,v in ipairs(heroList) do
    if v.isAvailable then
      table.insert(availHeroes, v)
    end
  end
  
  if #availHeroes > 2 then
    if math.random(100) > 60 then
      currentHero = availHeroes[math.random(len(availHeroes))]
    end
  end
  local params = {}
  currentHero = hero.new(params)
  return currentHero
end

function love.draw()
  ---- Draw Basic Background
  love.graphics.clear()
  love.graphics.setColor(220,220,220)
  love.graphics.setLineWidth(3)
  love.graphics.draw(bgImage, 0,0)
  love.graphics.line(0, 500, 1280, 500)  
  love.graphics.setColor(0,0,0,220)
  love.graphics.rectangle('fill', 0,500, 1280, 500)
  States:drawCurrentState()
end





function love.keyreleased(key)
  if key == 'escape' then
    love.event.quit()
  end
  
  Menu:processKey(key)
end


--------------------------------------------------------------------
-------------------- Global functions ------------------------------
--------------------------------------------------------------------

  


--  if key == "return" or key == "kpenter" then
--    if MODE == "INTRO" then
--      MODE = "NEWDAY"
--      generateDay()
--      textFunction = Text.pressEnter
    
--    elseif MODE == "NEWDAY" then
--      MODE = "GREET"
--      textFunction = Text.none
--      getOrGenerateHero()
--      -- generate a hero to use
--    elseif MODE == "GREET" then
--      MODE = "PLAY"

  
--  elseif MODE == "PLAY" then
--    Menu:processKey(key)
--  end
  
--  end
--end
