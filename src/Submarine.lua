-- submarine

-- the table that holds actual submarine status adn information

local s = {}

function s.new()
  local submarine = {}
  setmetatable(submarine, {__index = s})
  
  submarine.rooms = {engines = 'fine', 
                    quarters = 'fine', 
                    bridge = 'fine',
                    torpedos = 'fine'
                  }
  submarine.surfaced = true
  submarine.orientation = 0
  submarine.rudder = 0
  submarine.engines = 0
  submarine.x = 0
  submarine.y = 0
  
  
  return submarine
end

return s