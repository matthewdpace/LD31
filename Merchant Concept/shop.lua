-- shop.lua

-- manages the actual storefront / player

local Shop = {}

function Shop.new()
  local s = {}
  setmetatable(s, {__index = Shop})
  
  s.wealth = 100
  s.freeSpace = 120
  s.notoriety = 10
  s.townOpinion = 30
  
  
  return s
end

return Shop