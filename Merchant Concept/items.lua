-- item.lua


local Item = {}

Item.superTypes = {'potion', 'armor', 'weapon', 'ammo', 'loot', 'food'}
Item.weapons = {'mace', 'axe', 'sword', 'hammer', 'bow', 'crossbow'}
Item.armor = {'head', 'torso', 'shirt', 'boots', 'gloves', 'legs', 'shield'}
Item.weaponMaterials = {'copper', 'tin', 'bronze', 'iron', 'steel'}
Item.armorMaterials = {'leather', 'copper', 'tin', 'bronze', 'iron', 'steel'}


function Item.new()
  local s = {}
  setmetatable(s, {__index = Item })
  item.type = ''
  item.material = ''
  item.quality = 50
  
  return s
end


function Item.generateInventory(params)
  local i = {}
  local equipLevel = params.equipLevel or math.random(100)
  if equipLevel + math.random(25) > 100 then
    local helm = {}
    helm.type = Item.armor[math.random(2) - 1]
    helm.material = Item.armorMaterials[math.random(len(Item.armorMaterials))]
  end
end

    
return Item