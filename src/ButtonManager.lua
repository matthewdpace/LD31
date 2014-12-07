-- button manager

local ButtonManager = {}

function ButtonManager.new()
  local s = {}
  setmetatable(s, {__index = ButtonManager})
  
  s.mainButtons = {}
  s.mainButtons.fireSup = {x1 = 12}