-- sonar

local Sonar = {}

function Sonar.new()
  local s = {}
  setmetatable(s, {__index = Sonar})
  s.enabled = false
  return s
end



return sonar
