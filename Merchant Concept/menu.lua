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


function menu:drawHUD()
  love.graphics.setFont(self.menuFont)
  love.graphics.setColor(unpack(self.menuColor))
  love.graphics.printf(Shop.wealth .. " Gold avail", 900, 550, 360, 'right')
  love.graphics.printf(Shop.freeSpace .. " Space avail", 900, 585, 360, 'right')
end


function menu:processKey(key)
  if (States.curState.id < 5) then
    if (key == 'return' or key == 'kpenter') then
      States:goNext()
    end
  end
  if (States.curState.id == 5) then
    menu:processBuyKey(key)
  end
  if (States.curState.id == 6) then
    menu:processSellKey(key)
  end
end
  

----------------------------------------------------------
--------------------Hero Interaction----------------------
----------------------------------------------------------
function menu:heroGreet(greeting)
  love.graphics.setColor(unpack(menu.menuColor))
  love.graphics.printf(greeting, 20, 520, 1240, 'left')
  menu:pressEnter()
end


function menu:buyItem()
  -- CHANGE: Asking price
  if Shop.wealth >= sellQueue[self.sellIndex].value then
    Shop.wealth = Shop.wealth - sellQueue[self.sellIndex].value
    table.insert(Shop.inventory, table.remove(sellQueue, self.sellIndex))
  end
--  if #sellQueue < 1 then
--    return States:goNext()
--  end
  
end

menu.heroSell = { {active = false, text = "Buy Item!", coords={50, 600}, process =function() Menu:buyItem() end },
                  {active = false, text = "End buying", coords={200, 600}, process = function()States:goNext() end},
                  {active = false, text = "Negotiate an offer", coords={350, 600}}
                    
                }


menu.heroBuy = { {active = false, text = "Sell Item!", coords={50, 600}, process =function() Menu:buyItem() end },
                  {active = false, text = "Next Customer!", coords={200, 600}, process = function()States:goNext() end},
                  {active = false, text = "Negotiate an offer", coords={350, 600}}
                    
                }



menu.pause = {}
menu.pause.resume = {active = false, text = "Resume Game", coords={50, 600}}
menu.pause.quit = {active = false, text = "Quit Game", coords={50, 600}}

function menu:buyMenu()
  -- Loot for sale
  if #sellQueue > 0 then
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
  else
    love.graphics.setFont(menu.menuFont)
    love.graphics.setColor(menu.menuColor)
    love.graphics.print("I don't have anything else to sell to you", 30, 520)
    love.graphics.setColor(unpack(menu.activeColor))
    love.graphics.setFont(menu.activeFont)
    menu.heroSell[2].active = true
    menu.heroSell[1].active = false
    menu.heroSell[3].active = false
    love.graphics.print(menu.heroSell[2].text, menu.heroSell[2].coords[1], menu.heroSell[2].coords[2])
  end
  
    
  self:drawHUD()
end

function menu:processBuyKey(key)
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
function menu:buyMenu()
  -- Loot for sale
  if #sellQueue > 0 then
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
  else
    love.graphics.setFont(menu.menuFont)
    love.graphics.setColor(menu.menuColor)
    love.graphics.print("I don't have anything else to sell to you", 30, 520)
    love.graphics.setColor(unpack(menu.activeColor))
    love.graphics.setFont(menu.activeFont)
    menu.heroSell[2].active = true
    menu.heroSell[1].active = false
    menu.heroSell[3].active = false
    love.graphics.print(menu.heroSell[2].text, menu.heroSell[2].coords[1], menu.heroSell[2].coords[2])
  end
  self:drawHUD()
end

function menu:processSellKey(key)
  if (key == 'left') or (key == 'kp4') or (key == 'a') then
    local i = 0
    for k,v in pairs (menu.heroBuy) do
      if v.active then
        i = k
        break
      end
    end
    if i == 0 then
      -- no previous selection
      menu.heroBuy[1].active = true
    elseif i == 1 then
      menu.heroBuy[i].active = false
      menu.heroBuy[#menu.heroBuy].active = true
    else
      menu.heroBuy[i].active = false
      menu.heroBuy[i-1].active = true
    end
  end
  if (key == 'right') or (key == 'kp6') or (key == 'd') then
    local i = 0
    for k,v in pairs (menu.heroBuy) do
      if v.active then
        i = k
        break
      end
    end
    if i == 0 then
      -- no previous selection
      menu.heroBuy[1].active = true
    elseif i == #menu.heroBuy then
      menu.heroBuy[i].active = false
      menu.heroBuy[1].active = true
    else
      menu.heroBuy[i].active = false
      menu.heroBuy[i+1].active = true
    end
  end
  if (key == 'return') or (key == 'kpenter') then
    for k,v in ipairs(menu.heroBuy) do
      if v.active then
        v.process()
      end
    end
  end
  if (key == 'up') or (key == 'w') or (key == 'np8') then
    if Menu.buyIndex == 1 then
      Menu.buyIndex = #buyQueue
    else
      Menu.buyIndex = Menu.buyIndex - 1
    end
  end
  if (key == 'down') or (key == 's') or (key == 'kp2') then
    if Menu.buyIndex == #buyQueue then
      Menu.buyIndex = 1
    else
      Menu.buyIndex = Menu.buyIndex + 1
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
