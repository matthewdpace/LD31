-- item.lua


local Item = {}

local superTypes = {'potion', 'armor', 'weapon', 'ammo', 'loot', 'food'}
local weapons = {'mace', 'axe', 'sword', 'hammer', 'bow', 'crossbow'}
local armor = {'helm', 'cap', 'chain shirt', 'chest plate', 'gloves', 'plate leggings', 'shield', 'buckler'}
local weaponMaterials = {'copper', 'tin', 'bronze', 'iron', 'steel'}
local armorMaterials = {'leather', 'copper', 'tin', 'bronze', 'iron', 'steel'}


function Item.new()
  local s = {}
  setmetatable(s, {__index = Item })
  
  return s
end


function Item.generateInventory(params)
  local i = {}
  local equipLevel = params.equipLevel or math.random(100)
  if equipLevel + math.random(25) > 100 then
    local helm = {}
    helm.type = armor[math.random(2) - 1]
    helm.material = armorMaterials[math.random(len(armorMaterials))]
  end
end

    
return Item