--map

local Map = {}

function Map.new()
  local s = {}
  setmetatable(s, {__index = Map})
  
  s.enabled = false
  return s
end

function Map:enable()
  if not S.surfaced then
    -- only get GPS data when surfaced
    return
  end
else
  self.enabled =  true
end



return Map