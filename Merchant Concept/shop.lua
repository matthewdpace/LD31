-- shop.lua

-- manages the actual storefront / player

local shop = {}

function shop.new()
  local s = {}
  setmetatable(s, {__index = shop})
  
  s.wealth = 100
  s.freeSpace = 120
  s.notoriety = 10
  s.townOpinion = 30
  s.inventory = item.generateShopInventory(20)
  
  
  return s
end

return shop