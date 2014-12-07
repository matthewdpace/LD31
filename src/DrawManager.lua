-- Drawing functions

local DrawManager = {}

function DrawManager.new()
  local dm = {}
  x = 20
  setmetatable(dm, {__index = DrawManager})
  
  local width, height, flags = love.window.getMode()
  
  
  

  dm.w = width
  dm.h = height
  dm.canvas = love.graphics.newCanvas(width, height)
  
  return dm
end

function DrawManager:resize()
  local width, height, flags = love.window.getMode()
  self.w = width
  self.h = height
  self.canvas = nil
  collectgarbage()
  self.canvas = love.graphics.newCanvas(width, height)
end


function DrawManager:flip()
  love.graphics.draw(self.canvas, 0, 0)
end

function DrawManager:drawBase()
  --love.graphics.setCanvas(self.canvas)
  -- line definitions (change later for scaling ability)
  local panelBorder = {x1 = 50, y1 = 50, x2 = self.w-100, y2 =self.h - 100}
  local buttonBox = {x1 = 650, y1 = 80, x2 = 80, y2 = 450}
  local statusBox = {x1 = 560, y1 = 80, x2 = 80, y2 = 450}
  local displayBox = {x1 = 80, y1 = 80, x2 = 450, y2 = 450}
  
  
  love.graphics.clear()
  -- outer border
  love.graphics.setColor(0,0,0)
  love.graphics.setLineWidth(2)
  love.graphics.rectangle('line', panelBorder.x1,panelBorder.y1,panelBorder.x2,panelBorder.y2)
  -- right button panel
  love.graphics.rectangle('line', buttonBox.x1, buttonBox.y1, buttonBox.x2, buttonBox.y2)
  -- status panel
  love.graphics.rectangle('line', statusBox.x1, statusBox.y1, statusBox.x2, statusBox.y2)
  -- display
  love.graphics.rectangle('line', displayBox.x1, displayBox.y1, displayBox.x2, displayBox.y2)
  
  -- text section
  love.graphics.setColor(0,0,0)
  love.graphics.setFont(mainFont)
  love.graphics.printf('O2', 560, 90, 90, "center")
  love.graphics.printf('ENGINES', 560,120, 80, "center")
  love.graphics.printf('TORPEDO', 560, 150, 80, "center")
  love.graphics.printf('BARRACKS', 560, 180, 80, "center")
  love.graphics.printf('MESS', 560, 210, 80, "center")
  love.graphics.printf('AROMORY', 560, 240, 80, "center")
  love.graphics.printf('FUEL', 560, 270, 80, "center")
  love.graphics.printf('COMMAND', 560, 300, 80, "center")
  love.graphics.printf('BATTERY', 560, 330, 80, "center")
  love.graphics.printf('NAV', 560, 360, 80, "center")
  
  --love.graphics.printf('Engines', (statusBox.x1 + (statusBox.x2/2)), (statusBox.y1 + (statusBox.y2/2)), 1000, "center")
  --love.graphics.printf('O2', (statusBox.x1 + (statusBox.x2/2)+50), (statusBox.y1 + (statusBox.y2/2)), 1000, "center")
  love.graphics.setColor(15, 20, 80)
  for _,v in ipairs(BM:getButtons()) do
    love.graphics.rectangle('fill', v.x1, v.y1, (v.x2-v.x1), (v.y2-v.y1))
  end
  
    -- shit
  
end

return DrawManager