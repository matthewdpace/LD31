-- menus.lua

-- manages menus and user selection

local Menu = {
  menuColor = {200,200,200},
  activeColor = {100,100,200},
  menuFont = love.graphics.newFont('Triforce.ttf', 24),
  activeFont = love.graphics.newFont('Triforce.ttf', 28)  
  }


function Menu.new()
  local s = {}
  setmetatable(s, {__index = Menu})

  


  s.sellIndex = 1
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




function Menu:processKey(key)
  if (States.curState.id < 5) then
    if (key == 'return' or key == 'kpenter') then
      States:goNext()
    end
  end
  if (States.curState.id == 5) then
    Menu:processBarterKey(key)
  end
  
end
  
--  if self.curAction == 'MENU' then
--    if (key == 'down') or (key == 'kp2') or (key == 's') then
--      -- process as down movement in menu
--    elseif (key == 'up') or (key == 'kp8') or (key == 'w') then
--      -- process as up movement in menu
--    elseif (key == 'enter') or (key == 'kpenter') then
--      -- process as activating menu item
--    end
--  elseif (self.curAction == 'PRICING') then
--    if (key == 'down') or (key == 'kp2') then
--      self.curPrice = self.curPrice - 1
--      -- TODO no negatives
--    elseif (key == 'up') or (key == 'kp8') then
--      self.curPrice = self.curPrice +1
--    end
--  end

    
    
      
    


----------------------------------------------------------
--------------------Hero Interaction----------------------
----------------------------------------------------------
function Menu:heroGreet(greeting)
  love.graphics.setColor(unpack(Menu.menuColor))
  love.graphics.printf(greeting, 20, 520, 1240, 'left')
  Menu:pressEnter()
end


Menu.heroSell = { {active = false, text = "Buy Item!", coords={50, 600}, process =buyItem},
                  {active = false, text = "End buying", coords={200, 600}},
                  {active = false, text = "Negotiate an offer", coords={350, 600}}
                    
                }

-- Functions for processing hero selling functionality
local buyItem = function ()
  -- remove the item from inventory
  -- add the item to the player's store inventory
  -- move gold from player to hero
end


Menu.pause = {}
Menu.pause.resume = {active = false, text = "Resume Game", coords={50, 600}}
Menu.pause.quit = {active = false, text = "Quit Game", coords={50, 600}}

function Menu:barterMenu()
  -- Loot for sale
  love.graphics.setFont(Menu.menuFont)
  love.graphics.setColor(Menu.menuColor)
  love.graphics.print("G'day, I would like to sell my " .. sellQueue[self.sellIndex].material .. ' ' .. sellQueue[self.sellIndex].itemType, 30, 520)
  
  -- Player's options
  for _,v in ipairs(Menu.heroSell) do
    if v.active then
      love.graphics.setColor(unpack(Menu.activeColor))
      love.graphics.setFont(Menu.activeFont)
    else
      love.graphics.setFont(Menu.menuFont)
      love.graphics.setColor(unpack(Menu.menuColor))
    end
    love.graphics.print(v.text, v.coords[1], v.coords[2])
  end
end

function Menu:processBarterKey(key)
  if (key == 'left') or (key == 'kp4') or (key == 'a') then
    local i = 0
    for k,v in pairs (Menu.heroSell) do
      if v.active then
        i = k
        break
      end
    end
    if i == 0 then
      -- no previous selection
      Menu.heroSell[1].active = true
    
    elseif i == 1 then
      Menu.heroSell[i].active = false
      Menu.heroSell[#Menu.heroSell].active = true
    else
      Menu.heroSell[i].active = false
      Menu.heroSell[i-1].active = true
    end
  end
  if (key == 'right') or (key == 'kp6') or (key == 'd') then
    local i = 0
    for k,v in pairs (Menu.heroSell) do
      if v.active then
        i = k
        break
      end
    end
    if i == 0 then
      -- no previous selection
      Menu.heroSell[1].active = true
    
    elseif i == #Menu.heroSell then
      Menu.heroSell[i].active = false
      Menu.heroSell[1].active = true
    else
      Menu.heroSell[i].active = false
      Menu.heroSell[i+1].active = true
    end
  end




  if (key == 'return') or (key == 'kpenter') then
    for k,v in ipairs(Menu.heroSell) do
      if v.active then
        v.process()
      end
    end
  end
  
end


----------------------------------------------------------
-----------------------Main Menu--------------------------
----------------------------------------------------------




----------------------------------------------------------
-----------------------Intro Text-------------------------
----------------------------------------------------------

function Menu:intro()
  local introText = "Welcome to Dungeons and Margins IX: Financial Fantasy, a Ludum Dare 31 entry.    You play the role of a merchant, buying, selling, and trading wares with the heroic adventurers that wander through your town.$#%^^&&**()!"
  love.graphics.setFont(self.menuFont)
  love.graphics.setColor(unpack(self.menuColor))
  love.graphics.printf(introText, 20, 520, 1240, 'left')
  love.graphics.printf('Press [Enter] to begin!', 20, 580, 620, 'center')

end


return Menu
