-- states

-- manages game states and modes



local splashState = { id = 1,
                      nextState = 2,
                    }
function splashState.enter()
  -- load splash screen
end
function splashState.exit()
  -- unload splash screen
end


local introState = { id = 2,
                     nextState = 3,
                   }
function introState.enter()
  --l load intro state
end
function introState.exit()
  -- unload intro state
  print('exiting intro state')
end
function introState.draw()
  Menu:intro()
end
                   
local newsState = { id = 3,
                    nextState = 4
                  }
function newsState.enter()
  --load newsState
  -- TODO: Generate news events
end
function newsState.exit()
  -- unload newsState
  -- generate the day
  generateDay()
  --getOrGenerateHero()
end
function newsState.draw()
  love.graphics.setColor(200,200,200)
  love.graphics.rectangle('fill', 230,30,500,400)
  love.graphics.setColor(10,10,10)
  love.graphics.setFont(newsTitleFont)
  love.graphics.printf("Townie News", 220, 80, 600, 'center')
  love.graphics.setFont(newsTextFont)
  love.graphics.print("Some shit went down and some people got killed", 250, 120)
end

local greetState = { id = 4,
                    nextState = 5
                  }
function greetState.enter()
end
function greetState.exit()
end
function greetState.draw()
  Menu:heroGreet()
end



local buyState = { id = 5,
                    nextState = 6
                  }
function buyState.enter()
  Menu.heroSellingIDX = 1
  heroQueue[1]:sellLoot()
  Menu:adjustPrice()
end
function buyState.exit()
end
function buyState.draw()
  Menu:buyMenu()
end

local sellState = { id = 6,
      nextState = 4
    }
function sellState.enter()
  
  Menu.heroBuyingIDX = 1
  heroQueue[1]:createBuyList()
  Menu:adjustPrice()
end
function sellState.exit()
  -- recycle heroes
  heroQueue[1].isAvailable = true
  for _,v in ipairs(heroList) do
    if v == heroQueue[1] then
      goto continue
    end
  end
  table.insert(heroList, heroQueue[1])
  ::continue::
  
  -- if it's teh last hero start a new day
  if #heroQueue < 2 then
    sellState.nextState = 3
  else
    sellState.nextState = 4
  end
  table.remove(heroQueue, 1)
end
function sellState.draw()
  Menu:sellMenu()
end
    


stateList = { splashState, introState, newsState, greetState, buyState, sellState}
local states = {}

function states.new()
  local s = {}
  setmetatable(s, {__index = states})
  
  -- TODO: splash screen
  --s.curState = splashState
  s.curState = stateList[2]

  return s
end

function states:drawCurrentState()
  if not self.curState then
    return
  end
  
  self.curState.draw()
end

function states:goNext()
  self.curState.exit()
  for k,v in ipairs(stateList) do
    if self.curState.nextState == v.id then
      self.curState = v
      self.curState.enter()
      return
    end
  end
  
    -- if error restart the gaem as debug tool
    self.curState = stateList[1]
end





return states
