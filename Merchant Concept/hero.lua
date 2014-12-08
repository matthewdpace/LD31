-- hero.lua
-- manages and creates heroes


local hero = {}

local items = require('item')

function hero.new(params)
  params = params or {}
  local s = {}
  s.name = hero.generateName()
  s.greeting = "Hello, do you have any skooma?  I need to stay up all night to create a game"
  
  s.notoriety = params.notoriety or math.random(100)
  s.charisma = params.charisma or math.random(100)
  s.wealth = params.wealth or math.random(100, 1000)
  s.weaponPrefs = params.weaponPrefs or math.random(#item.weapons)
  s.friendRating = params.friendRating or math.random(-100, 100)
  
  s.equipment = item.generateInventory(params)
  s.loot = item.generateLoot(params)
  
  setmetatable(s, {__index = hero})
  
  return s
  
end

function hero:checkWants(storeInventory)
  for _,v in ipairs(items.armor) do
    for _, u in ipairs(s.equipment) do
      if u.type ~= v then
        -- shop for this item
      end
    end
  end
end

function hero:sellLoot()
  for k,v in ipairs(self.loot) do
    table.insert(sellQueue, v)
  end
end

function hero.generateName()
  local firstNames = {'Jarah', 'Ansha', 'Ealric', 'Jackord', 'Briege', 'Joric', 'Elwin', 'Annye', 'Zelda', 'Link', 'Aryll', 'Ajani', 'Chandra', 'Jace', 'Ashiok', 'Urza', 'Dusty', 'Charbri', 'Acia', 'Laueli', 'Hieldigel', 'Rolhal'}
  local lastNames = {'Bowsheep', 'Walkerhame', 'Landermace', 'Forcefury', 'Duskbrave', 'Hiltcarver', 'Goldmane', 'Thrune', 'Bravelord', 'Seasword', 'Plainsblood', 'Rockcarry', 'Bornesword', 'Fallmight', 'Oakenshield', 'Castleraid', 'Nighthawk', 'Woodsmash', 'Windstaff', 'Black', 'Smith', 'Silver'}
  return firstNames[math.random(#firstNames)] .. ' ' .. lastNames[math.random(#lastNames)]
end

return hero