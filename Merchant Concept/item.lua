-- item.lua


local item = {}

item.superTypes = {'potion', 'armor', 'weapon', 'ammo', 'loot', 'food'}
item.potionTypes = {'health', 'mana', 'restoration'}
item.weapons = {'mace', 'axe', 'sword', 'hammer', 'bow', 'crossbow'}
item.armor = {'helmet', 'breastplate', 'boots', 'gloves', 'legs', 'shield'}
item.weaponMaterials = {'copper', 'tin', 'bronze', 'iron', 'steel', 'unobtanium'}
item.armorMaterials = {'leather', 'copper', 'tin', 'bronze', 'iron', 'steel', 'mithril'}
item.loot = {'scepter', 'crown', 'amulet', 'ring', 'goblet', 'talisman', 'trinket', 'trophy', 'tourist crap', '"abstract" sculpture'}


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
  -- these table names are base gold values

  local value = 0
  --local qfactor = (self.quality - 50) * math.random()
  local values = {}
  local found = {false, false}  
  values[5] =  {'trinket', 'tourist crap', 'leather'}
  values[10] =  {'talisman', 'goblet', 'trophy', 'copper', 'tin', 'health', 'mana', 'boots', 'gloves'}
  values[20] = {'crossbow', 'hammer', 'helmet', 'crown', 'amulet', 'ring', 'scepter', '"abstract" sculpture', 'helmet', 'legs', 'restoration'}
  values[30] = {'mace', 'axe', 'bow', 'iron', 'bronze', 'shield'}
  values[40] = {'breastplate', 'sword', 'steel'}
  values[50] = {'unobtanium'}
  for i,j in pairs(values) do
    for k,v in pairs(j) do
      if self.material == v then
        value = value + math.ceil(i * self.quality/100)
        found[1] = true
      end
      if self.itemType == v then
        value = value + math.ceil(i * self.quality/100)
        found[2] = true
      end
      if found[1] and found[2] then
        goto continue
      end
      
    end
  end
  ::continue::
  self.value = value
      
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
  if equipLevel + math.random(25) > 70 then
    local helm = item.new()
    helm.itemType = item.armor[1]
    helm.material = item.armorMaterials[math.random(#item.armorMaterials)]
    table.insert(i, helm)
  end
  if equipLevel + math.random(25) > 30 then
    local chest = item.new()
    chest.itemType = item.armor[2]
    chest.material = item.armorMaterials[math.random(#item.armorMaterials)]
    table.insert(i, chest)
  end
  if equipLevel + math.random(25) > 40 then
    local feet = item.new()
    feet.itemType = item.armor[3]
    feet.material = item.armorMaterials[math.random(#item.armorMaterials)]
    table.insert(i, feet)
  end
    if equipLevel + math.random(25) > 40 then
    local shield = item.new()
    shield.itemType = item.armor[6]
    shield.material = item.armorMaterials[math.random(#item.armorMaterials)]
    table.insert(i, shield)
  end
end
function item.generateLoot(params)
  params = params or {}
  local loot = {}
  for i=1, math.random(10) do
    local k = item.new()
    k.itemType = item.loot[math.random(#item.loot)]
    k.material = item.weaponMaterials[math.random(#item.weaponMaterials)]
    k:calcValue()
    table.insert(loot, k)
  end
  return loot
end

function item.generateShopInventory(count)
  local items = {}
  local x = {}
  for i=1, count do
    x = item.new()
    x.itemType = item.weapons[math.random(#item.weapons)]
    x.material = item.weaponMaterials[math.random(#item.weaponMaterials)]
    x:calcValue()
    table.insert(items, x)
  end
    for i=1, count do
    x = item.new()
    x.itemType = item.armor[math.random(#item.armor)]
    x.material = item.armorMaterials[math.random(#item.armorMaterials)]
    x:calcValue()
    table.insert(items, x)
  end
  for i=1, count do
    x = item.new()
    x.itemType = item.potionTypes[math.random(#item.potionTypes)]
    x:calcValue()
    table.insert(items, x)
  end
  return items
end
    
return item