-- menus.lua

-- manages menus and user selection

local Menu = {}


----------------------------------------------------------
--------------------Hero Interaction----------------------
----------------------------------------------------------
Menu.heroSell = {}
Menu.heroSell.buyItem = {active = false, text = "Buy Item!"}
Menu.heroSell.endTransaction = {active = false, text = "End buying"}
Menu.heroSell.offer = {active = false, text = "Negotiate an offer"}

Menu.pause = {}
Menu.pause.resume = {active = false, text = "Resume Game"}
Menu.pause.quit = {active = false, text = "Quit Game"}


----------------------------------------------------------
-----------------------Main Menu--------------------------
----------------------------------------------------------



function Menu.new()
  local s = {}
  setmetatable(s, {__index = Menu})
  s.menuFont = love.graphics.newFont('Triforce.ttf', 18)
  s.activeFont = love.graphics.newFont('Triforce.ttf', 16)
  return s
  
end





return Menu
