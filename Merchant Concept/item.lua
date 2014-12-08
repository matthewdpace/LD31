-- item.lua


local item = {}

item.superTypes = {'potion', 'armor', 'weapon', 'ammo', 'loot', 'food'}
item.potionTypes = {'health', 'mana', 'restoration'}
item.weapons = {'mace', 'axe', 'sword', 'hammer', 'bow', 'crossbow'}
item.armor = {'head', 'torso', 'shirt', 'boots', 'gloves', 'legs', 'shield'}
item.weaponMaterials = {'copper', 'tin', 'bronze', 'iron', 'steel', 'unobtanium'}
item.armorMaterials = {'leather', 'copper', 'tin', 'bronze', 'iron', 'steel', 'mithril'}
item.loot = {'scepter', 'crown', 'amulet', 'ring', 'goblet', 'talisman', 'book', 'trinket', 'trophy', 'tourist crap', '"abstract" sculpture'}


function item.new()
  local s = {}
  setmetatable(s, {__index = item })
  s.itemType = ''
  s.material = ''
  s.quality = math.random(100)
  s.descriptor = item.getAdjective(s.quality)
  
  
  return s
end



function item:calcValue()
  
end
function item.getAdjective(quality)
  local adj = {}
  if quality < 10 then
    adj = {'horrid', 'shoddy', 'junked', 'poorly made', 'worthless', 'ruined'}
  elseif quality < 20 then
    adj = {'damaged', 'ugly', 'amateur', 'blood and bowel stained', 'battle scarred'}
  elseif quality < 30 then
    adj = {'unappealing', 'slightly damaged', 'abused'}
  elseif quality < 40 then
    adj = {'slightly worn', 'mediocre', 'peasant'}
  elseif quality < 60 then
    adj = {'mediocre', 'average', 'typical', 'unnoteworthy', 'bland'}
  elseif quality < 70 then
    adj = {'decent', 'nifty', 'good', 'above average', 'good looking'}
  elseif quality < 80 then
    adj = {'well-crafted', 'fine quality', 'high-grade', 'well-designed', 'artisinal'}
  elseif quality < 90 then
    adj = {'impressive', 'excellent', 'notable', 'beautiful'}
  elseif quality < 100 then
    adj = {'masterwork', 'top tier', 'exquisite', 'masterfully crafted'}
  elseif quality == 100 then
    adj = {'Legendary', 'Perfect', 'Mythical'}
  end
  
  return adj[math.random(#adj)]
end

      
function item.generateInventory(params)
  params = params or {}
  local i = {}
  local equipLevel = params.equipLevel or math.random(100)
  if equipLevel + math.random(25) > 100 then
    local helm = item.new()
    helm.itemType = item.armor[math.random(2) - 1]
    helm.material = item.armorMaterials[math.random(#item.armorMaterials)]
    i.head = helm
  end
  if equipLevel + math.random(25) > 60 then
    local chest = item.new()
    --chest.type = item.armor[math.random(2) - 1]
    chest.material = item.armorMaterials[math.random(#item.armorMaterials)]
    i.chest = chest
  end

end
function item.generateLoot(params)
  params = params or {}
  local loot = {}
  for i=1, math.random(10) do
    local k = item.new()
    k.itemType = item.loot[math.random(#item.loot)]
    k.material = item.weaponMaterials[math.random(#item.weaponMaterials)]
    table.insert(loot, k)
  end
  return loot
end

    
return item