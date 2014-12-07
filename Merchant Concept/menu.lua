-- menus.lua

-- manages menus and user selection

local Menu = {
  menuColor = {200,200,200},
  activeColor = {100,100,200},
  menuFont = love.graphics.newFont('Triforce.ttf', 28),
  activeFont = love.graphics.newFont('Triforce.ttf', 24)  
  }


function Menu.new()
  local s = {}
  setmetatable(s, {__index = Menu})

  


  
  s.active = false
  s.curMenuItems = {}
  s.curAction = ''
  return s
  
end


----------------------------------------------------------
--------------------General Purpose-----------------------
----------------------------------------------------------
function Menu:pressEnter()
  love.graphics.setFont(self.menuFont)
  love.graphics.setColor(unpack(self.activeColor))
  love.graphics.printf('Press [Enter] to continue!', 600, 580, 620, 'center')
end

function Menu:drawText()
  if States.mode == 'INTRO' then
    Menu:intro()
    Menu:pressEnter()
  elseif false then
    --do somethign
  end
end


function Menu:processKey(key)
  if self.curAction == 'MENU' then
    if (key == 'down') or (key == 'kp2') or (key == 's') then
      -- process as down movement in menu
    elseif (key == 'up') or (key == 'kp8') or (key == 'w') then
      -- process as up movement in menu
    elseif (key == 'enter') or (key == 'kpenter') then
      -- process as activating menu item
    end
  elseif (self.curAction == 'PRICING') then
    if (key == 'down') or (key == 'kp2') then
      self.curPrice = self.curPrice - 1
      -- TODO no negatives
    elseif (key == 'up') or (key == 'kp8') then
      self.curPrice = self.curPrice +1
    end
  end
end

    
    
      
    


----------------------------------------------------------
--------------------Hero Interaction----------------------
----------------------------------------------------------
Menu.heroSell = {}

Menu.heroSell.buyItem = {active = false, text = "Buy Item!"}
Menu.heroSell.endTransaction = {active = false, text = "End buying"}
Menu.heroSell.offer = {active = false, text = "Negotiate an offer"}

Menu.pause = {}
Menu.pause.resume = {active = false, text = "Resume Game"}
Menu.pause.quit = {active = false, text = "Quit Game"}


----------------------------------------------------------
-----------------------Main Menu--------------------------
----------------------------------------------------------




----------------------------------------------------------
-----------------------Intro Text-------------------------
----------------------------------------------------------

function Menu:intro()
  local introText = "Welcome to Untitled game, a Ludum Dare 31 entry.    You play the role of a merchant, buying, selling, and trading wares with the heroic adventurers that wander through your town."
  love.graphics.setFont(self.menuFont)
  love.graphics.setColor(unpack(self.menuColor))
  love.graphics.printf(introText, 20, 520, 1240, 'left')
  love.graphics.printf('Press [Enter] to begin!', 20, 580, 620, 'center')

end


return Menu
