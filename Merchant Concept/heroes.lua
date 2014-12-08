-- hero.lua
-- manages and creates heroes

Items = require ('items')

local Hero = {}


function Hero.new(params)
  params = params or {}
  local s = {}
  s.name = "Hero McHeroson"
  s.greeting = "Hello, do you have any skooma?  I need to stay up all night to create a game"
  
  s.notoriety = params.notoriety or math.random(100)
  s.charisma = params.charisma or math.random(100)
  s.wealth = params.wealth or math.random(100, 1000)
  s.weaponPrefs = params.weaponPrefs or math.random(#Items.weapons)
  s.friendRating = params.friendRating or math.random(-100, 100)
  
  s.equipment = Items.generateInventory(params)
  s.loot = Items.generateLoot(params)
  
  setmetatable(s, {__index = Hero})
  
  return s
  
end

function Hero:checkWants(storeInventory)
  for _,v in ipairs(Items.armor) do
    for _, u in ipairs(s.equipment) do
      if u.type ~= v then
        -- shop for this item
      end
    end
  end
end

function Hero:sellLoot()
for k,v in ipairs(self.loot) do
  table.insert(sellQueue, v)
end


end

return Hero