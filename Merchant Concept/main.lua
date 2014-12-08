-- merchant game



ItemsM = require('items')
HeroesM = require('heroes')
ShopM = require('shop')
EventsM = require('events')
MenuM = require('menu')
--Text = require ('text')
StatesM = require('states')



currentDay = {}
currentHero = {}
currentLootForSale = {}
heroList = {}

NPCText = {}

States = StatesM.new()
Menu = MenuM.new()
Shop = ShopM.new()
Heroes = HeroesM.new()


function love.load(arg)

  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
  end


  love.graphics.setBackgroundColor(120,120,120)
  bgImage = love.graphics.newImage('Merchant Built Stall Test_resized.png')
  
  newsTitleFont = love.graphics.newFont('IHATCS__.ttf', 42)
  newsTextFont = love.graphics.newFont('IHATCS__.ttf', 24)
  
  NPCText.enabled = false
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
  
  if #availHeroes > 2 then
    if math.random(100) > 60 then
      currentHero = availHeroes[math.random(len(availHeroes))]
    end
  end
  local params = {}
  currentHero = Heroes.new(params)
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
  
  -- text box

  --love.graphics.setFont(menuFont)
  --love.graphics.setColor(220,220,220)
  --love.graphics.printf(displayText, 20, 520, 1240, 'left')
  --textFunction()

    -- NPC text box
  if NPCText.enabled then
    love.graphics.setFont(menuFont)
    love.graphics.setColor(120,120,120, 10)
    love.graphics.rectangle('fill',700, 200, 850, 350)
    love.graphics.setColor(200,200,200)
    love.graphics.print(NPCText.text, 760,210)
  end
  
end





function love.keyreleased(key)
  if key == 'escape' then
    love.event.quit()
  end
  
  Menu:processKey(key)
end


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
