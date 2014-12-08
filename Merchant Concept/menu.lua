-- menus.lua

-- manages menus and user selection

local menu = {
  menuColor = {200,200,200},
  activeColor = {100,100,200},
  menuFont = love.graphics.newFont('Triforce.ttf', 28),
  activeFont = love.graphics.newFont('Triforce.ttf', 32)  
  }


function menu.new()
  local s = {}
  setmetatable(s, {__index = menu})

  


  s.sellIndex = 1
  s.active = false
  s.curmenuItems = {}
  s.curAction = ''
  return s
  
end


----------------------------------------------------------
--------------------General Purpose-----------------------
----------------------------------------------------------
function menu:pressEnter()
  love.graphics.setFont(self.menuFont)
  love.graphics.setColor(unpack(self.activeColor))
  love.graphics.printf('Press [Enter] to continue!', 600, 580, 620, 'center')
end




function menu:processKey(key)
  if (States.curState.id < 5) then
    if (key == 'return' or key == 'kpenter') then
      States:goNext()
    end
  end
  if (States.curState.id == 5) then
    menu:processBarterKey(key)
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
function menu:heroGreet(greeting)
  love.graphics.setColor(unpack(menu.menuColor))
  love.graphics.printf(greeting, 20, 520, 1240, 'left')
  menu:pressEnter()
end


menu.heroSell = { {active = false, text = "Buy Item!", coords={50, 600}, process =buyItem},
                  {active = false, text = "End buying", coords={200, 600}},
                  {active = false, text = "Negotiate an offer", coords={350, 600}}
                    
                }

-- Functions for processing hero selling functionality
local buyItem = function ()
  -- remove the item from inventory
  -- add the item to the player's store inventory
  -- move gold from player to hero
end


menu.pause = {}
menu.pause.resume = {active = false, text = "Resume Game", coords={50, 600}}
menu.pause.quit = {active = false, text = "Quit Game", coords={50, 600}}

function menu:barterMenu()
  -- Loot for sale
  
  love.graphics.setFont(menu.menuFont)
  love.graphics.setColor(menu.menuColor)
  love.graphics.print("G'day, I would like to sell my " .. sellQueue[self.sellIndex].descriptor .. ' '.. sellQueue[self.sellIndex].material .. ' ' .. sellQueue[self.sellIndex].itemType, 30, 520)
  love.graphics.print("I am willing to part with this fine treasure for only " .. 
    sellQueue[self.sellIndex].value .. " gold", 30, 550)
  
  -- Player's options
  for _,v in ipairs(menu.heroSell) do
    if v.active then
      love.graphics.setColor(unpack(menu.activeColor))
      love.graphics.setFont(menu.activeFont)
    else
      love.graphics.setFont(menu.menuFont)
      love.graphics.setColor(unpack(menu.menuColor))
    end
    love.graphics.print(v.text, v.coords[1], v.coords[2])
  end
end

function menu:processBarterKey(key)
  if (key == 'left') or (key == 'kp4') or (key == 'a') then
    local i = 0
    for k,v in pairs (menu.heroSell) do
      if v.active then
        i = k
        break
      end
    end
    if i == 0 then
      -- no previous selection
      menu.heroSell[1].active = true
    
    elseif i == 1 then
      menu.heroSell[i].active = false
      menu.heroSell[#menu.heroSell].active = true
    else
      menu.heroSell[i].active = false
      menu.heroSell[i-1].active = true
    end
  end
  if (key == 'right') or (key == 'kp6') or (key == 'd') then
    local i = 0
    for k,v in pairs (menu.heroSell) do
      if v.active then
        i = k
        break
      end
    end
    if i == 0 then
      -- no previous selection
      menu.heroSell[1].active = true
    
    elseif i == #menu.heroSell then
      menu.heroSell[i].active = false
      menu.heroSell[1].active = true
    else
      menu.heroSell[i].active = false
      menu.heroSell[i+1].active = true
    end
  end




  if (key == 'return') or (key == 'kpenter') then
    for k,v in ipairs(menu.heroSell) do
      if v.active then
        v.process()
      end
    end
  end
  
  if (key == 'up') or (key == 'w') or (key == 'np8') then
    if Menu.sellIndex == 1 then
      Menu.sellIndex = #sellQueue
    else
      Menu.sellIndex = Menu.sellIndex - 1
    end
  end
  if (key == 'down') or (key == 's') or (key == 'kp2') then
    if Menu.sellIndex == #sellQueue then
      Menu.sellIndex = 1
    else
      Menu.sellIndex = Menu.sellIndex + 1
    end
  end
  


end


----------------------------------------------------------
-----------------------Main menu--------------------------
----------------------------------------------------------




----------------------------------------------------------
-----------------------Intro Text-------------------------
----------------------------------------------------------

function menu:intro()
  local introText = "Welcome to Dungeons and Margins IX: Financial Fantasy, a Ludum Dare 31 entry.    You play the role of a merchant, buying, selling, and trading wares with the heroic adventurers that wander through your town."
  love.graphics.setFont(self.menuFont)
  love.graphics.setColor(unpack(self.menuColor))
  love.graphics.printf(introText, 20, 520, 1240, 'left')
  love.graphics.printf('Press [Enter] to begin!', 20, 580, 620, 'center')

end


return menu
