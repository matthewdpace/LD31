-- button manager

local ButtonManager = {}

function ButtonManager.new()
  local s = {}
  setmetatable(s, {__index = ButtonManager})
  
  s.mainButtons = {}
  s.mainButtons.btn1 = {x1 = 650, y1 = 90, x2=730, y2 = 119, text = "btn 1"}
  s.mainButtons.btn1 = {x1 = 650, y1 = 120, x2=730, y2 = 149, text = "btn 2"}
  s.mainButtons.btn1 = {x1 = 650, y1 = 150, x2=730, y2 = 179, text = "btn 3"}
  s.mainButtons.btn1 = {x1 = 650, y1 = 180, x2=730, y2 = 209, text = "btn 4"}
  s.mainButtons.btn1 = {x1 = 650, y1 = 210, x2=730, y2 = 239, text = "btn 5"}
  s.mainButtons.btn1 = {x1 = 650, y1 = 240, x2=730, y2 = 269, text = "btn 6"}
  s.mainButtons.btn1 = {x1 = 650, y1 = 270, x2=730, y2 = 299, text = "btn 7"}
  s.mainButtons.btn1 = {x1 = 650, y1 = 300, x2=730, y2 = 329, text = "btn 8"}
  return s
end

function ButtonManager:getButtons()
  return self.mainButtons
end

function ButtonManager:process(x,y)
  for _, v in ipairs(self.mainButtons) do 
    if (x >= v.x1) and (x <=v.x2) and (x >= y1) and (x <= y2) then
      --press that shit
    end
  end
end

return ButtonManager