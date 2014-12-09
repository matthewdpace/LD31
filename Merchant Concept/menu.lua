-- menus.lua

-- manages menus and user selection

local menu = {
  menuColor = {200,200,200},
  activeColor = {100,100,200},
  menuFont = love.graphics.newFont('Triforce.ttf', 28),
  activeFont = love.graphics.newFont('Triforce.ttf', 32)  
  }

heroSellingIDX = 1
heroBuyingIDX = 1


function menu.new()
  local s = {}
  setmetatable(s, {__index = menu})

  




  return s
  
end


----------------------------------------------------------
--------------------General Purpose-----------------------
----------------------------------------------------------
function menu:adjustPrice()
  heroQueue[1]:calculatePrice(heroSellingQueue[heroSellingIDX])
end


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
      return
    end
  end
  if (States.curState.id == 5) then
    menu:processBuyKey(key)
    return
  end
  if (States.curState.id == 6) then
    menu:processSellKey(key)
    return
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
  if Shop.wealth >= heroSellingQueue[heroSellingIDX].value then
    Shop.wealth = Shop.wealth - heroSellingQueue[heroSellingIDX].value
    table.insert(Shop.inventory, table.remove(heroSellingQueue, heroSellingIDX))
    self:adjustPrice()
  end
end
function menu:sellItem()
  table.insert(heroQueue[1].equipment, heroBuyingQueue[heroBuyingIDX])
  Shop.wealth = Shop.wealth + heroBuyingQueue[heroBuyingIDX].value
  for k,v in ipairs(Shop.inventory) do
    if v == heroBuyingQueue[heroBuyingIDX] then
      table.remove(Shop.inventory, k)
      break
    end
    self:adjustPrice()
  end
end

function negotiateHeroBuy()
  curHeroItemBuyPrice = curHeroItemBuyPrice + math.random(math.floor(curHeroItemBuyPrice/5)) 
end

function negotiateHeroSell()
  curHeroItemSellPrice = curHeroItemSellPrice - math.random(math.floor(curHeroItemSellPrice/5)) 
end


menu.heroSell = { {active = false, text = "Buy Item!", coords={50, 600}, process =function() Menu:buyItem() end },
                  {active = false, text = "End buying", coords={200, 600}, process = function()States:goNext() end},
                  {active = false, text = "Negotiate an offer", coords={350, 600}, process = function() negotiateHeroSell() end}
                    
                }




menu.heroBuy = { {active = false, text = "Sell Item!", coords={50, 600}, process =function() Menu:sellItem() end },
                  {active = false, text = "Next Customer!", coords={200, 600}, process = function()States:goNext() end},

                  {active = false, text = "Negotiate an offer", coords={420, 600}, process = function() negotiateHeroBuy() end}

                    
                }



menu.pause = {}
menu.pause.resume = {active = false, text = "Resume Game", coords={50, 600}}
menu.pause.quit = {active = false, text = "Quit Game", coords={50, 600}}

function menu:buyMenu()
  
  -- Loot for sale
  if #heroSellingQueue > 0 then
    love.graphics.setFont(menu.menuFont)
    love.graphics.setColor(menu.menuColor)
    love.graphics.print("G'day, I would like to sell my " .. heroSellingQueue[heroSellingIDX].descriptor .. ' '.. heroSellingQueue[heroSellingIDX].material .. ' ' .. heroSellingQueue[heroSellingIDX].itemType, 30, 520)
    love.graphics.print("I am willing to part with this fine treasure for only " .. 
      curHeroItemSellPrice .. " gold", 30, 550)
    
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
        return
      end
    end
  end
  
  if (key == 'up') or (key == 'w') or (key == 'np8') then
    if heroSellingIDX == 1 then
      heroSellingIDX = #heroSellingQueue
    else
      heroSellingIDX = heroSellingIDX - 1
    end
    self:adjustPrice(heroSellingQueue[heroSellingIDX])
  end
  if (key == 'down') or (key == 's') or (key == 'kp2') then
    if heroSellingIDX == #heroSellingQueue then
      heroSellingIDX = 1
    else
      heroSellingIDX = heroSellingIDX + 1
    end
    self:adjustPrice(heroSellingQueue[heroSellingIDX])
  end
end




function menu:sellMenu()
  
  -- Loot for sale
  if #heroBuyingQueue > 0 then
    love.graphics.setFont(menu.menuFont)
    love.graphics.setColor(menu.menuColor)
    love.graphics.print("G'day, I would like to see what you have for sale", 30, 520)

    love.graphics.print("I like this " .. heroBuyingQueue[heroBuyingIDX].descriptor .. ' ' .. heroBuyingQueue[heroBuyingIDX].material .. ' ' .. heroBuyingQueue[heroBuyingIDX].itemType ..'.  I am willing to offer ' .. curHeroItemBuyPrice .. " gold", 30, 550)

    
    -- Player's options
    for _,v in ipairs(menu.heroBuy) do
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
    love.graphics.print("You do not have anything else I want to buy", 30, 520)
    love.graphics.setColor(unpack(menu.activeColor))
    love.graphics.setFont(menu.activeFont)
    menu.heroBuy[2].active = true
    menu.heroBuy[1].active = false
    menu.heroBuy[3].active = false
    love.graphics.print(menu.heroBuy[2].text, menu.heroBuy[2].coords[1], menu.heroBuy[2].coords[2])
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
        return
      end
    end
  end
  if (key == 'up') or (key == 'w') or (key == 'np8') then
    if heroBuyingIDX == 1 then
      heroBuyingIDX = #heroBuyingQueue
    else
      heroBuyingIDX = heroBuyingIDX - 1
    end
    self:adjustPrice(heroBuyingQueue[heroBuyingIDX])
  end
  if (key == 'down') or (key == 's') or (key == 'kp2') then
    if heroBuyingIDX == #heroBuyingQueue then
      heroBuyingIDX = 1
    else
      heroBuyingIDX = heroBuyingIDX + 1
    end
    self:adjustPrice(heroBuyingQueue[heroBuyingIDX])
  end
end

----------------------------------------------------------
-----------------------Main menu--------------------------
----------------------------------------------------------




----------------------------------------------------------
-----------------------Intro Text-------------------------
----------------------------------------------------------

function menu:intro()
  local introText = "Welcome to Dungeons and Margins VII: Financial Fantasy, a Ludum Dare 31 entry.    You play the role of a merchant, buying, selling, and trading wares with the heroic adventurers that wander through your town."
  love.graphics.setFont(self.menuFont)
  love.graphics.setColor(unpack(self.menuColor))
  love.graphics.printf(introText, 20, 520, 1240, 'left')
  love.graphics.printf('Press [Enter] to begin!', 20, 580, 620, 'center')

end


return menu
