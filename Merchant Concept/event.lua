-- events.lua

local event = {}

function event.new()
  local s = {}
  setmetatable(s, {__index = event})
end



return event