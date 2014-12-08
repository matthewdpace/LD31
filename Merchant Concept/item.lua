-- item.lua


local item = {}

item.superTypes = {'potion', 'armor', 'weapon', 'ammo', 'loot', 'food'}
item.weapons = {'mace', 'axe', 'sword', 'hammer', 'bow', 'crossbow'}
item.armor = {'head', 'torso', 'shirt', 'boots', 'gloves', 'legs', 'shield'}
item.weaponMaterials = {'copper', 'tin', 'bronze', 'iron', 'steel', 'unobtanium'}
item.armorMaterials = {'leather', 'copper', 'tin', 'bronze', 'iron', 'steel', 'mithril'}
item.loot = {'scepter', 'crown', 'amulet', 'ring', 'goblet', 'talisman', 'book', 'trinket', 'trophy', 'tourist crap', '"abstract" sculpture'}


function item.new()
  local s = {}
  setmetatable(s, {__index = item })
  item.itemType = ''
  item.material = ''
  item.quality = 50
  
  return s
end


function item.generateInventory(params)
  params = params or {}
  local i = {}
  local equipLevel = params.equipLevel or math.random(100)
  if equipLevel + math.random(25) > 100 then
    local helm = {}
    helm.itemType = item.armor[math.random(2) - 1]
    helm.material = item.armorMaterials[math.random(#item.armorMaterials)]
    i.head = helm
  end
  if equipLevel + math.random(25) > 60 then
    local chest = {}
    --chest.type = item.armor[math.random(2) - 1]
    chest.material = item.armorMaterials[math.random(#item.armorMaterials)]
    i.chest = chest
  end

end
function item.generateLoot(params)
  params = params or {}
  local loot = {}
  for i=1, math.random(10) do
    local k = {}
    k.itemType = item.loot[math.random(#item.loot)]
    k.material = item.weaponMaterials[math.random(#item.weaponMaterials)]
    table.insert(loot, k)
  end
  return loot
end

    
return item