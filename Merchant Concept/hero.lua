-- hero.lua
-- manages and creates heroes


local hero = {}

local items = require('item')

function hero.new(params)
  params = params or {}
  local s = {}
  s.name = hero.generateName()
  s.greeting = hero.greetings[math.random(#hero.greetings)]  
  s.notoriety = params.notoriety or math.random(100)
  s.charisma = params.charisma or math.random(100)
  s.wealth = params.wealth or math.random(100, 1000)
  s.weaponPrefs = params.weaponPrefs or math.random(#item.weapons)
  s.friendRating = params.friendRating or math.random(-100, 100)
  s.lootPref = items.loot[math.random(#items.loot)]
  s.equipment = item.generateInventory(params)
  s.loot = item.generateLoot(params)
  
  setmetatable(s, {__index = hero})
  
  return s
  
end
function hero:calculatePrice(item)
  local v = item.value
  if item.itemType == self.lootPref then
    local pref = math.ceil(v/2)
    v = v + math.random(pref)
  end
  curHeroItemBuyPrice = math.max(v + math.ceil(self.friendRating/8), 1)
  curHeroItemSellPrice = math.max(v - math.ceil(self.friendRating/8), 1)
  
  -- adventurers weren't causing a decay in wealth by just power smashing [enter]
  curHeroItemBuyPrice = math.ceil(curHeroItemBuyPrice * 0.8)
  curHeroItemSellPrice = math.ceil(curHeroItemSellPrice * 1.2)
end

function hero:createBuyList()
  heroBuyingQueue = {}
  local wants = self:checkWants()
  for k,v in ipairs(wants) do
    for i,j in ipairs(Shop.inventory) do
      if v == j.itemType then
        table.insert(heroBuyingQueue, j)
      end
    end
  end
end

function hero:checkWants()
  local required = {}
  for _,v in ipairs(items.armor) do
    local found = false
    for _, u in ipairs(self.equipment or {}) do
      if u.type == v then
        found = true
        break
      end
    end
    if not found then
      table.insert(required, v)
    end
    table.insert(required, self.lootPref)
  end
  return required
end

function hero:sellLoot()
  heroSellingQueue = {}
  for k,v in ipairs(self.loot) do
    table.insert(heroSellingQueue, v)
  end
end

function hero:negotiateLower()
  curHeroItemSellPrice = curHeroItemSellPrice - math.random(math.floor(curHeroItemSellPrice/5))
  self.friendRating = self.friendRating - math.random(5)
  self.patience = self.patience - 1
  if self.patience < 1 then
    States:goNext()
    States:goNext()
  end
  
end
function hero:negotiateHigher()
  curHeroItemBuyPrice = curHeroItemBuyPrice + math.random(math.floor(curHeroItemBuyPrice/5))
  self.friendRating = self.friendRating - math.random(5)
  self.patience = self.patience - 1
  if self.patience < 1 then
    States:goNext()
  end
  
end

function hero:endShopping()

end


function hero.generateName()
  local firstNames = {'Jarah', 'Ansha', 'Ealric', 'Jackord', 'Briege', 'Joric', 'Elwin', 'Annye', 'Zelda', 'Link', 'Aryll', 'Ajani', 'Chandra', 'Jace', 'Ashiok', 'Urza', 'Dusty', 'Charbri', 'Acia', 'Laueli', 'Hieldigel', 'Rolhal'}
  local lastNames = {'Bowsheep', 'Walkerhame', 'Landermace', 'Forcefury', 'Duskbrave', 'Hiltcarver', 'Goldmane', 'Thrune', 'Bravelord', 'Seasword', 'Plainsblood', 'Rockcarry', 'Bornesword', 'Fallmight', 'Oakenshield', 'Castleraid', 'Nighthawk', 'Woodsmash', 'Windstaff', 'Black', 'Smith', 'Silver'}
  return firstNames[math.random(#firstNames)] .. ' ' .. lastNames[math.random(#lastNames)]
end
hero.greetings = {'Hello!  It truly is a wonderful morning for slaying goblins!', 'Bro, do you even triforce? *', 'The last merchant I went to sold me bad mana potions.  My aura was leaky for a week!', 'I hear there are bandits in the hills, I need protection', 'I was a merchant like you, until I took an arrow in the knee', "I'm looking for armor for my girlfriend.  No I don't care about how well it protects her, I just want her to look good on the battlefield.", "I have to join the Night's Watch.  What do you have in black?", 'Can I have a minute of your time to discuss the glorious omnipotent being called Dee-Em?', 'A rogue walks into a bar.... He makes his save and takes no damage since he has Evasion.', "What do you call a Wood Elf who doesn't lie or cheat or steal? A dead Wood Elf.", "What is the thinnest book in the world? Redguard Heroes of the War of Betony.", 'I am looking for a gift for my newphew.  I know he likes green clothing, but I was thinking maybe a flute or something?', 'Hey do you know where I can find some skooma?', "Do you know why Ganon can't use the internet?  There's too many Links."}


  
return hero