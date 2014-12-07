-- events.lua

local Event = {}

function Event.new()
  local s = {}
  setmetatable(s, {__index = Event})
end



return Event