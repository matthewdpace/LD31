-- texts.lua

-- a table of the in game text

local text = {}


--[[
text.intro = "Welcome to Untitled game, a Ludum Dare 31 entry.    You play the role of a merchant, buying, selling, and trading wares with the heroic adventurers that wander through your town. \n\n\n Press [Enter] to begin"
--]]

function text.none()
  return
end

function text.pressEnter()
  love.graphics.setFont(menuFont)
  love.graphics.setColor(220,220,220)
  love.graphics.printf('Press [Enter] to continue!', 300, 580, 620, 'center')
end


function text.intro()
  local introText = "Welcome to Untitled game, a Ludum Dare 31 entry.    You play the role of a merchant, buying, selling, and trading wares with the heroic adventurers that wander through your town."
  love.graphics.setFont(menuFont)
  love.graphics.setColor(220,220,220)
  love.graphics.printf(introText, 20, 520, 1240, 'left')
  love.graphics.printf('Press [Enter] to begin!', 20, 580, 620, 'center')

end

text.firstNames = {'Antonio', 'Clarise', 'Edgen', "Armok", "Gallahad", "Joan", "Jameson"}
text.lastNames = {"Anderson", "Smith", "Smythe", "The basher dasher", "of the Sea", "Donger", "Dingleberry"}



return text